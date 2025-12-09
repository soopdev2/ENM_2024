/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rc.so.db;

import com.google.common.base.Splitter;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import rc.so.domain.Comuni;
import rc.so.domain.Docenti;
import rc.so.domain.FasceDocenti;
import rc.so.domain.Lezioni_Modelli;
import rc.so.domain.ProgettiFormativi;
import rc.so.domain.SediFormazione;
import rc.so.domain.SoggettiAttuatori;
import rc.so.entity.FadCalendar;
import rc.so.entity.Item;
import rc.so.util.Fadroom;
import rc.so.util.Utenti;
import rc.so.util.Utility;
import static rc.so.util.Utility.LOGAPP;
import static rc.so.util.Utility.calcoladurata;
import static rc.so.util.Utility.createDir;
import static rc.so.util.Utility.estraiEccezione;
import static rc.so.util.Utility.formatStringtoStringDate;
import static rc.so.util.Utility.getUtilDate;
import static rc.so.util.Utility.patternFile;
import static rc.so.util.Utility.patternITA;
import static rc.so.util.Utility.patternSql;
import static rc.so.util.Utility.preparefilefordownload;
import static rc.so.util.Utility.sdfSQL;
import static rc.so.util.Utility.test;
import static rc.so.util.Utility.timestampSQL;
import java.io.File;
import java.io.IOException;
import static java.lang.Class.forName;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.concurrent.atomic.AtomicLong;
import java.util.logging.Level;
import static org.apache.commons.codec.binary.Base64.decodeBase64;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import static org.apache.commons.lang3.StringUtils.right;
import static org.apache.commons.lang3.StringUtils.stripAccents;
import org.apache.commons.text.StringEscapeUtils;
import org.joda.time.DateTime;
import rc.so.domain.Allievi;
import rc.so.domain.Presenze_Lezioni_Allievi;
import static rc.so.util.Utility.conf;

/**
 *
 * @author rcosco
 */
public class Database {

    private final Entity entity;
    private static final DateTimeFormatter timestampSQL = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public Database(boolean bando) {
        this.entity = new Entity();
    }

    public void closeDB() {
        // Chiudiamo il contesto JPA
        this.entity.close();
    }

    public EntityManager getEm() {
        return this.entity.getEm();
    }

    public String getNow() {
        try {
            Query q = this.entity.getEm().createNativeQuery("SELECT NOW()");
            Object result = q.getSingleResult();
            if (result != null) {
                return result.toString();
            }
        } catch (Exception ex) {
            LOGAPP.log(Level.SEVERE, "Errore durante getNow", ex);
        }
        return new DateTime().toString("yyyy-MM-dd HH:mm:ss");
    }

    public void insertTR(String type, String user, String descr) {
        Entity e = new Entity();
        try {
            e.begin();
            // query nativa identica all'SQL originale
            Query q = e.getEm().createNativeQuery(
                    "INSERT INTO tracking (azione, iduser, timestamp) VALUES (?, ?, ?)"
            );
            q.setParameter(1, descr);
            q.setParameter(2, user);
            q.setParameter(3, getNow());
            q.executeUpdate();
            e.commit();
        } catch (Exception ex) {
            e.rollBack();
            LOGAPP.log(Level.SEVERE, "Errore durante insertTR", ex);
        } finally {
            e.close();
        }
    }

    public int countPregresso() {
        Entity e = new Entity();
        int count = 0;
        try {
            Query q = e.getEm().createNativeQuery("SELECT COUNT(idallievi_pregresso) FROM allievi_pregresso");
            Object result = q.getSingleResult();

            if (result != null) {
                count = ((Number) result).intValue();
            }

        } catch (Exception ex) {
            count = 0;
            LOGAPP.log(Level.SEVERE, "Errore in countPregresso", ex);
        } finally {
            e.close();
        }

        return count;
    }

    public List<Fadroom> listStanzeOGGI() {
        Entity e = new Entity();
        List<Fadroom> out = new ArrayList<>();

        try {
            String sql = """
            SELECT room, idprogetti_formativi
            FROM fad_access
            WHERE DATA LIKE CONCAT(CURDATE(), '%')
            GROUP BY idprogetti_formativi, room
        """;

            Query q = e.getEm().createNativeQuery(sql);
            List<Object[]> results = q.getResultList();

            for (Object[] row : results) {
                String room = (String) row[0];
                String idProgetto = String.valueOf(row[1]);
                String lastChar = room != null && !room.isEmpty()
                        ? room.substring(room.length() - 1)
                        : "";
                out.add(new Fadroom(room, idProgetto, lastChar, "0"));
            }

        } catch (Exception ex) {
            LOGAPP.log(Level.SEVERE, "Errore in listStanzeOGGI", ex);
        } finally {
            e.close();
        }

        return out;
    }

    public List<Fadroom> listStanzeOGGISA(Long idsa) {
        Entity e = new Entity();
        List<Fadroom> out = new ArrayList<>();

        try {
            String sql = """
            SELECT room, idprogetti_formativi
            FROM fad_access
            WHERE data LIKE CONCAT(CURDATE(), '%')
              AND idprogetti_formativi IN (
                  SELECT idprogetti_formativi
                  FROM progetti_formativi
                  WHERE (stato = 'ATA' OR stato = 'ATB')
                    AND idsoggetti_attuatori = :idsa
              )
            GROUP BY idprogetti_formativi, room
        """;

            Query q = e.getEm().createNativeQuery(sql);
            q.setParameter("idsa", idsa);

            List<Object[]> results = q.getResultList();

            for (Object[] row : results) {
                String room = (String) row[0];
                String idProgetto = String.valueOf(row[1]);
                String lastChar = room != null && !room.isEmpty()
                        ? room.substring(room.length() - 1)
                        : "";
                out.add(new Fadroom(room, idProgetto, lastChar, "0"));
            }

        } catch (Exception ex) {
            // LOGAPP.log(Level.SEVERE, "Errore in listStanzeOGGISA", ex);
        } finally {
            e.close();
        }

        return out;
    }

    public List<Fadroom> listStanze() {
        Entity e = new Entity();
        List<Fadroom> out = new ArrayList<>();

        try {
            String sql = "SELECT * FROM fad_multi WHERE stato = '0'";
            Query q = e.getEm().createNativeQuery(sql);

            List<Object[]> results = q.getResultList();

            for (Object[] row : results) {
                String col1 = (String) row[0];
                String col2 = String.valueOf(row[1]);
                String col3 = (String) row[2];
                String col5 = (String) row[4];

                out.add(new Fadroom(col1, col2, col3, col5));
            }

        } catch (Exception ex) {
            LOGAPP.log(Level.SEVERE, "Errore in listStanze", ex);
        } finally {
            e.close();
        }

        return out;
    }

    public List<Item> listReport() {
        Entity e = new Entity();
        List<Item> out = new ArrayList<>();

        try {
            String sql = "SELECT * FROM fad_report";
            Query q = e.getEm().createNativeQuery(sql);

            List<Object[]> results = q.getResultList();

            for (Object[] row : results) {
                // rs.getString(1), rs.getString(2), ""
                String col1 = (String) row[0];
                String col2 = (String) row[1];
                out.add(new Item(col1, col2, ""));
            }

        } catch (Exception ex) {
            LOGAPP.log(Level.SEVERE, "Errore in listReport", ex);
        } finally {
            e.close();
        }

        return out;
    }

    public String getBase64Report(int idpr) {
        Entity e = new Entity();
        String out = null;

        try {
            String sql = "SELECT base64 FROM fad_report WHERE idprogetti_formativi = :idpr";
            Query q = e.getEm().createNativeQuery(sql);
            q.setParameter("idpr", idpr);

            Object result = q.getSingleResult();
            if (result != null) {
                out = StringEscapeUtils.escapeHtml4(result.toString());
            }

        } catch (Exception ex) {
            LOGAPP.log(Level.SEVERE, "Errore in getBase64Report", ex);
            out = null;
        } finally {
            e.close();
        }

        return out;
    }

    public List<Item> listStanza() {
        Entity e = new Entity();
        List<Item> out = new ArrayList<>();

        try {
            String sql = "SELECT idprogetti_formativi, nomestanza FROM fad WHERE stato = '0'";
            Query q = e.getEm().createNativeQuery(sql);

            List<Object[]> results = q.getResultList();
            for (Object[] row : results) {
                String id = String.valueOf(row[0]);
                String nome = (String) row[1];
                out.add(new Item(id, nome, nome));
            }

        } catch (Exception ex) {
            LOGAPP.log(Level.SEVERE, "Errore in listStanza", ex);
        } finally {
            e.close();
        }

        return out;
    }

    public String getPathtemp(String id) {
        Entity e = new Entity();
        String path = "/mnt/mcn/test/temp/";

        try {
            String sql = "SELECT url FROM path WHERE id = :id";
            Query q = e.getEm().createNativeQuery(sql);
            q.setParameter("id", id);

            Object result = q.getSingleResult();
            if (result != null) {
                path = result.toString();
            }

        } catch (Exception ex) {
            LOGAPP.log(Level.SEVERE, "Errore in getPathtemp", ex);
        } finally {
            e.close();
        }

        return path;
    }

    private static String sanitizePath(String path) {
        return path.replaceAll("[^a-zA-Z0-9-_./]", "");
    }

    public String getNomePR_F(String id) {
        Entity e = new Entity();
        String nome = "Progetto Formativo";

        try {
            String sql = "SELECT descrizione FROM progetti_formativi WHERE idprogetti_formativi = :id";
            Query q = e.getEm().createNativeQuery(sql);
            q.setParameter("id", id);

            Object result = q.getSingleResult();
            if (result != null) {
                nome = result.toString();
            }

        } catch (Exception ex) {
            LOGAPP.log(Level.SEVERE, "Errore in getNomePR_F", ex);
        } finally {
            e.close();
        }

        return nome;
    }

    public List<FadCalendar> calendarioFAD(String id) {
        Entity e = new Entity();
        List<FadCalendar> out = new ArrayList<>();

        try {
            String sql = """
            SELECT numerocorso, data, orainizio, orafine
            FROM fad_calendar
            WHERE idprogetti_formativi = :id
            ORDER BY numerocorso, data
        """;

            Query q = e.getEm().createNativeQuery(sql);
            q.setParameter("id", id);

            List<Object[]> results = q.getResultList();

            for (Object[] row : results) {
                String numerocorso = (String) row[0];
                String dataStr = (String) row[1];
                String orainizioStr = (String) row[2];
                String orafineStr = (String) row[3];

                if (orainizioStr != null && orainizioStr.contains(";")) {
                    List<String> orainizio = Splitter.on(";").splitToList(orainizioStr);
                    List<String> orafine = Splitter.on(";").splitToList(orafineStr);
                    for (int x = 0; x < orainizio.size(); x++) {
                        out.add(new FadCalendar(
                                id,
                                numerocorso,
                                formatStringtoStringDate(dataStr, patternSql, patternITA, false),
                                orainizio.get(x),
                                orafine.get(x)
                        ));
                    }
                } else {
                    out.add(new FadCalendar(
                            id,
                            numerocorso,
                            formatStringtoStringDate(dataStr, patternSql, patternITA, false),
                            orainizioStr,
                            orafineStr
                    ));
                }
            }

        } catch (Exception ex) {
            LOGAPP.log(Level.SEVERE, "Errore in calendarioFAD", ex);
        } finally {
            e.close();
        }

        return out;
    }

    public boolean insertcalendarioFAD(String idpr, String corso, String data, String orainizio, String orafine) {
        Entity e = new Entity();
        boolean out = false;

        try {
            e.begin();

            String selectSql = """
            SELECT f.numerocorso, f.orainizio, f.orafine
            FROM fad_calendar f
            WHERE f.idprogetti_formativi = :idpr
              AND f.numerocorso = :corso
              AND f.data = :data
        """;

            Query selectQuery = e.getEm().createNativeQuery(selectSql);
            selectQuery.setParameter("idpr", idpr);
            selectQuery.setParameter("corso", corso);
            selectQuery.setParameter("data", data);

            @SuppressWarnings("unchecked")
            List<Object[]> results = selectQuery.getResultList();

            if (!results.isEmpty()) {
                Object[] row = results.get(0);
                String orainizio_old = (String) row[1];
                String orafine_old = (String) row[2];

                String orainizio_new = orainizio_old + ";" + orainizio;
                String orafine_new = orafine_old + ";" + orafine;

                String updateSql = """
                UPDATE fad_calendar
                SET orainizio = :orainizio, orafine = :orafine
                WHERE idprogetti_formativi = :idpr
                  AND numerocorso = :corso
                  AND data = :data
                  AND orainizio = :orainizioOld
                  AND orafine = :orafineOld
            """;

                Query updateQuery = e.getEm().createNativeQuery(updateSql);
                updateQuery.setParameter("orainizio", orainizio_new);
                updateQuery.setParameter("orafine", orafine_new);
                updateQuery.setParameter("idpr", idpr);
                updateQuery.setParameter("corso", corso);
                updateQuery.setParameter("data", data);
                updateQuery.setParameter("orainizioOld", orainizio_old);
                updateQuery.setParameter("orafineOld", orafine_old);

                updateQuery.executeUpdate();
            } else {
                String insertSql = """
                INSERT INTO fad_calendar (idprogetti_formativi, numerocorso, data, orainizio, orafine)
                VALUES (:idpr, :corso, :data, :orainizio, :orafine)
            """;

                Query insertQuery = e.getEm().createNativeQuery(insertSql);
                insertQuery.setParameter("idpr", idpr);
                insertQuery.setParameter("corso", corso);
                insertQuery.setParameter("data", data);
                insertQuery.setParameter("orainizio", orainizio);
                insertQuery.setParameter("orafine", orafine);

                insertQuery.executeUpdate();
            }

            e.commit();
            out = true;

        } catch (Exception ex) {
            e.rollBack();
            LOGAPP.log(Level.SEVERE, "Errore in insertcalendarioFAD", ex);
            out = false;
        } finally {
            e.close();
        }

        return out;
    }

    public boolean removecalendarioFAD(String idpr, String corso, String inizio, String data) {
        Entity e = new Entity();
        boolean out = false;

        try {
            e.begin();

            String selectSql = """
            SELECT numerocorso, orainizio, orafine
            FROM fad_calendar
            WHERE idprogetti_formativi = :idpr
              AND numerocorso = :corso
              AND data = :data
              AND orainizio LIKE :inizio
        """;

            Query selectQuery = e.getEm().createNativeQuery(selectSql);
            selectQuery.setParameter("idpr", idpr);
            selectQuery.setParameter("corso", corso);
            selectQuery.setParameter("data", data);
            selectQuery.setParameter("inizio", "%" + inizio + "%");

            @SuppressWarnings("unchecked")
            List<Object[]> results = selectQuery.getResultList();

            if (!results.isEmpty()) {
                Object[] row = results.get(0);
                String orainizioStr = (String) row[1];
                String orafineStr = (String) row[2];

                if (orainizioStr.contains(";")) {
                    LinkedList<String> orainizioList = new LinkedList<>(Splitter.on(";").splitToList(orainizioStr));
                    LinkedList<String> orafineList = new LinkedList<>(Splitter.on(";").splitToList(orafineStr));
                    int idx = orainizioList.indexOf(inizio);

                    if (idx >= 0) {
                        orainizioList.remove(idx);
                        orafineList.remove(idx);

                        String orainizioNew = String.join(";", orainizioList);
                        String orafineNew = String.join(";", orafineList);

                        String updateSql = """
                        UPDATE fad_calendar
                        SET orainizio = :orainizio, orafine = :orafine
                        WHERE idprogetti_formativi = :idpr
                          AND numerocorso = :corso
                          AND data = :data
                          AND orainizio = :orainizioOld
                          AND orafine = :orafineOld
                    """;

                        Query updateQuery = e.getEm().createNativeQuery(updateSql);
                        updateQuery.setParameter("orainizio", orainizioNew);
                        updateQuery.setParameter("orafine", orafineNew);
                        updateQuery.setParameter("idpr", idpr);
                        updateQuery.setParameter("corso", corso);
                        updateQuery.setParameter("data", data);
                        updateQuery.setParameter("orainizioOld", orainizioStr);
                        updateQuery.setParameter("orafineOld", orafineStr);

                        updateQuery.executeUpdate();
                        out = true;
                    }

                } else {
                    String deleteSql = """
                    DELETE FROM fad_calendar
                    WHERE idprogetti_formativi = :idpr
                      AND numerocorso = :corso
                      AND data = :data
                      AND orainizio = :orainizio
                      AND orafine = :orafine
                """;

                    Query deleteQuery = e.getEm().createNativeQuery(deleteSql);
                    deleteQuery.setParameter("idpr", idpr);
                    deleteQuery.setParameter("corso", corso);
                    deleteQuery.setParameter("data", data);
                    deleteQuery.setParameter("orainizio", orainizioStr);
                    deleteQuery.setParameter("orafine", orafineStr);

                    deleteQuery.executeUpdate();
                    out = true;
                }
            }

            e.commit();

        } catch (Exception ex) {
            e.rollBack();
            LOGAPP.log(Level.SEVERE, "Errore in removecalendarioFAD", ex);
            out = false;
        } finally {
            e.close();
        }

        return out;
    }

    public SoggettiAttuatori estrai_SA_accettare(Entity en, String id) {
        SoggettiAttuatori sa = null;

        Entity e = new Entity();
        try {
            String sql = """
            SELECT a.id, a.username, a.sedecap, a.cellulare, a.cf, a.cognome, a.data, a.datadecreto,
                   a.mail, a.sedeindirizzo, a.nome, a.docric, a.pec, a.pivacf, a.protocollo, a.societa,
                   a.scadenzadoc, a.cellulare AS cell2, a.sedecomune, a.dataupconvenzionefinale,
                   a.decreto, a.datadecreto AS datadecreto2, a.caricasoc
            FROM bando_toscana_mcn a
            WHERE a.id = :id
        """;

            Query query = e.getEm().createNativeQuery(sql);
            query.setParameter("id", Long.valueOf(id));

            @SuppressWarnings("unchecked")
            List<Object[]> results = query.getResultList();

            if (!results.isEmpty()) {
                Object[] rs = results.get(0);
                sa = new SoggettiAttuatori();

                sa.setId(((Number) rs[0]).longValue());
                sa.setUsernameaccr((String) rs[1]);
                sa.setCap((String) rs[2]);
                sa.setTelefono_sa((String) rs[3]);
                sa.setCodicefiscale((String) rs[4]);
                sa.setCognome((String) rs[5]);
                sa.setDatanascita(getUtilDate((String) rs[6], patternITA));
                sa.setVisual_dataprotocollo((String) rs[7]);
                sa.setEmail((String) rs[8]);
                sa.setIndirizzo((String) rs[9]);
                sa.setNome((String) rs[10]);
                sa.setNro_documento((String) rs[11]);
                sa.setPec((String) rs[12]);
                sa.setPiva((String) rs[13]);
                sa.setProtocollo((String) rs[14]);
                sa.setRagionesociale((String) rs[15]);
                sa.setScadenza(getUtilDate((String) rs[16], patternITA));
                sa.setCell_sa((String) rs[17]);
                sa.setComune(en.getComune(Long.valueOf((String) rs[18])));
                sa.setDataprotocollo(getUtilDate((String) rs[19], patternITA));
                sa.setDd((String) rs[20] + " DEL " + (String) rs[21]);
                sa.setCarica((String) rs[22]);

                sa.setNome_refente(sa.getNome());
                sa.setCognome_referente(sa.getCognome());
                sa.setTelefono_Ad(sa.getTelefono_sa());
                sa.setTelefono_referente(sa.getTelefono_sa());
            }

        } catch (Exception ex) {
            LOGAPP.log(Level.SEVERE, "Errore in estrai_SA_accettare", ex);
        } finally {
            e.close();
        }

        return sa;
    }

    public List<SoggettiAttuatori> estrai_SA_accettare(Entity en) {
        Entity e = new Entity();
        List<SoggettiAttuatori> out = new LinkedList<>();

        try {
            String sql = """
            SELECT a.id, a.username, a.sedecap, a.cellulare, a.cf, a.cognome, a.data, a.datadecreto,
                   a.mail, a.sedeindirizzo, a.nome, a.docric, a.pec, a.pivacf, a.protocollo, a.societa,
                   a.scadenzadoc, a.cellulare AS cell2, a.sedecomune
            FROM bando_toscana_mcn a
            WHERE stato_domanda = 'A' AND dataupconvenzionefinale <> '-'
        """;

            Query query = e.getEm().createNativeQuery(sql);

            @SuppressWarnings("unchecked")
            List<Object[]> results = query.getResultList();

            for (Object[] rs : results) {
                SoggettiAttuatori sa = new SoggettiAttuatori();

                sa.setId(((Number) rs[0]).longValue());
                sa.setUsernameaccr((String) rs[1]);
                sa.setCap((String) rs[2]);
                sa.setTelefono_sa((String) rs[3]);
                sa.setCodicefiscale((String) rs[4]);
                sa.setCognome((String) rs[5]);
                sa.setDatanascita(getUtilDate((String) rs[6], patternITA));
                sa.setDataprotocollo(getUtilDate((String) rs[7], patternITA));
                sa.setEmail((String) rs[8]);
                sa.setIndirizzo((String) rs[9]);
                sa.setNome((String) rs[10]);
                sa.setNro_documento((String) rs[11]);
                sa.setPec((String) rs[12]);
                sa.setPiva((String) rs[13]);
                sa.setProtocollo((String) rs[14]);
                sa.setRagionesociale((String) rs[15]);
                sa.setScadenza(getUtilDate((String) rs[16], patternITA));
                sa.setCell_sa((String) rs[17]);
                sa.setComune(en.getComune(Long.valueOf((String) rs[18])));

                sa.setNome_refente(sa.getNome());
                sa.setCognome_referente(sa.getCognome());
                sa.setTelefono_Ad(sa.getTelefono_sa());
                sa.setTelefono_referente(sa.getTelefono_sa());
                sa.setVisual_dataprotocollo((String) rs[7]);

                out.add(sa);
            }

        } catch (Exception ex) {
            LOGAPP.log(Level.SEVERE, "Errore in estrai_SA_accettare", ex);
        } finally {
            e.close();
        }

        return out;
    }

    public FileDownload getDocumentoIdentitaSA(String username) {
        FileDownload out = null;
        Entity e = new Entity();

        try {
            String sql = """
            SELECT path
            FROM docuserbandi
            WHERE username = :username
              AND codicedoc = 'DOCR'
              AND stato = '1'
            ORDER BY datacar DESC
            LIMIT 1
        """;

            Query query = e.getEm().createNativeQuery(sql);
            query.setParameter("username", username);

            @SuppressWarnings("unchecked")
            List<Object> results = query.getResultList();

            if (!results.isEmpty() && results.get(0) != null) {
                out = preparefilefordownload(results.get(0).toString());
            }

        } catch (Exception ex) {
            out = null;
            LOGAPP.log(Level.SEVERE, "Errore in getDocumentoIdentitaSA", ex);
        } finally {
            e.close();
        }

        return out;
    }

    public List<SediFormazione> estrai_SEDI_SA(SoggettiAttuatori sa, Entity en, String ragionesociale) {
        Entity e = new Entity();
        List<SediFormazione> out = new LinkedList<>();
        String username = sa.getUsernameaccr();

        try {
            String sql = """
            SELECT numaule,
                   mailresponsabile1, indirizzo1, responsabile1, telresponsabile1, citta1,
                   mailresponsabile2, indirizzo2, responsabile2, telresponsabile2, citta2,
                   mailresponsabile3, indirizzo3, responsabile3, telresponsabile3, citta3,
                   mailresponsabile4, indirizzo4, responsabile4, telresponsabile4, citta4,
                   mailresponsabile5, indirizzo5, responsabile5, telresponsabile5, citta5
            FROM allegato_a a
            WHERE username = :username
        """;

            Query query = e.getEm().createNativeQuery(sql);
            query.setParameter("username", username);

            @SuppressWarnings("unchecked")
            List<Object[]> results = query.getResultList();

            if (!results.isEmpty()) {
                Object[] rs = results.get(0);
                int numaule = Integer.parseInt(rs[0].toString());

                for (int i = 1; i <= numaule; i++) {
                    String denominazione = ragionesociale + " - SEDE " + i;
                    String via = (String) rs[2 + (i - 1) * 5];            // indirizzoX
                    String referente = (String) rs[3 + (i - 1) * 5];       // responsabileX
                    String telefono = (String) rs[4 + (i - 1) * 5];        // telresponsabileX
                    String cellulare = (String) rs[4 + (i - 1) * 5];      // stesso numero
                    String email = (String) rs[1 + (i - 1) * 5];          // mailresponsabileX
                    Long idComune = Long.valueOf(rs[5 + (i - 1) * 5].toString());
                    Comuni cm = en.getEm().find(Comuni.class, idComune);

                    SediFormazione sf = new SediFormazione(denominazione, via, referente, telefono, cellulare, email, cm);
                    sf.setSoggetto(sa);
                    out.add(sf);
                }
            }

        } catch (Exception ex) {
            out = null;
            LOGAPP.log(Level.SEVERE, "Errore in estrai_SEDI_SA", ex);
        } finally {
            e.close();
        }

        return out;
    }

    public List<Docenti> estrai_DOCENTI_SA(SoggettiAttuatori sa, Entity en) {
        List<Docenti> out = new LinkedList<>();
        Entity e = new Entity();

        try {
            String username = sa.getUsernameaccr();
            String date = new DateTime().toString(patternFile);

            String sql = """
            SELECT id, UPPER(nome), UPPER(cognome), UPPER(cf), datanascita, LOWER(mail)
            FROM allegato_b
            WHERE username = :username
            GROUP BY cf
            ORDER BY id
        """;

            Query query = e.getEm().createNativeQuery(sql);
            query.setParameter("username", username);

            @SuppressWarnings("unchecked")
            List<Object[]> results = query.getResultList();

            for (Object[] rs : results) {
                String id = Utility.sanitizeInput(rs[0].toString());
                String nome = Utility.sanitizeInput((String) rs[1]);
                String cognome = Utility.sanitizeInput((String) rs[2]);
                String cf = Utility.sanitizeInput((String) rs[3]);
                Date data_nascita = getUtilDate(rs[4].toString(), patternITA);
                String fascia = "FA";
                String email = Utility.sanitizeInput((String) rs[5]);

                Docenti d = new Docenti(nome, cognome, cf, data_nascita, email);
                d.setSoggetto(sa);
                d.setFascia(en.getEm().find(FasceDocenti.class, fascia));

                String sql1 = """
                SELECT allegatocv, allegatodr
                FROM allegato_b1
                WHERE username = :username AND idallegato_b1 = :id
            """;

                Query query1 = e.getEm().createNativeQuery(sql1);
                query1.setParameter("username", username);
                query1.setParameter("id", id);

                @SuppressWarnings("unchecked")
                List<Object[]> docResults = query1.getResultList();

                if (!docResults.isEmpty()) {
                    Object[] rs1 = docResults.get(0);

                    String path = en.getPath("pathDoc_Docenti").replace("@docente", d.getCodicefiscale());
                    createDir(path);

                    FileDownload allegatocv = preparefilefordownload(Utility.sanitizeInput(rs1[0].toString()));
                    FileDownload allegatodr = preparefilefordownload(Utility.sanitizeInput(rs1[1].toString()));

                    if (allegatocv != null && allegatodr != null) {
                        String ext1 = "." + FilenameUtils.getExtension(allegatocv.getName());
                        String ext2 = "." + FilenameUtils.getExtension(allegatodr.getName());

                        File dest1 = new File(path + "Curriculum_" + sa.getId() + "_" + date + "_" + d.getCodicefiscale() + ext1);
                        File dest2 = new File(path + "Doc_id_" + sa.getId() + "_" + date + "_" + d.getCodicefiscale() + ext2);

                        FileUtils.writeByteArrayToFile(dest1, decodeBase64(allegatocv.getContent()));
                        FileUtils.writeByteArrayToFile(dest2, decodeBase64(allegatodr.getContent()));

                        if (dest1.length() > 0 && dest2.length() > 0) {
                            d.setScadenza_doc(new SimpleDateFormat(patternITA).parse("31/12/2031"));
                            d.setCurriculum(dest1.getPath());
                            d.setDocId(dest2.getPath());
                            d.setStato("DV");
                            out.add(d);
                        }
                    }
                }
            }

        } catch (IOException | IllegalArgumentException | ParseException ex) {
            ex.printStackTrace();
            LOGAPP.log(Level.SEVERE, "Errore in estrai_DOCENTI_SA", ex);
        } finally {
            e.close();
        }

        return out;
    }

    //Totale Ore rendicontabili per Maschera Modello 5
    public Map<Long, Long> OreRendicontabiliDocentiFASEA(int pf) {
        Map<Long, Long> result = new HashMap<>();
        Entity e = new Entity();

        try {
            if (Utility.demoversion) {
                String sql1 = """
                SELECT MAX(totaleorerendicontabili) AS totOre, idutente
                FROM registro_completo
                WHERE fase = 'A'
                  AND idutente IN (
                      SELECT DISTINCT idutente
                      FROM registro_completo
                      WHERE fase = 'A'
                        AND idprogetti_formativi = :pf
                        AND ruolo = 'DOCENTE'
                  )
                GROUP BY idutente, data
            """;

                Query query1 = e.getEm().createNativeQuery(sql1);
                query1.setParameter("pf", pf);

                @SuppressWarnings("unchecked")
                List<Object[]> results1 = query1.getResultList();

                for (Object[] row : results1) {
                    Long idutente = ((Number) row[1]).longValue();
                    Long totOre = ((Number) row[0]).longValue();

                    result.merge(idutente, totOre, Long::sum); // somma se esiste già
                }

            } else {
                String sql2 = """
                SELECT SUM(totaleorerendicontabili) AS totOre, idutente
                FROM registro_completo
                WHERE ruolo = 'DOCENTE'
                  AND fase = 'A'
                  AND idprogetti_formativi = :pf
                GROUP BY idutente
            """;

                Query query2 = e.getEm().createNativeQuery(sql2);
                query2.setParameter("pf", pf);

                @SuppressWarnings("unchecked")
                List<Object[]> results2 = query2.getResultList();

                for (Object[] row : results2) {
                    Long idutente = ((Number) row[1]).longValue();
                    Long totOre = ((Number) row[0]).longValue();
                    result.put(idutente, totOre);
                }
            }

        } catch (Exception ex) {
            LOGAPP.log(Level.SEVERE, "Errore in OreRendicontabiliDocentiFASEA", ex);
        } finally {
            e.close();
        }

        return result;
    }

    public Map<Long, Long> OreRendicontabiliDocenti(int pf) {
        Map<Long, Long> result = new HashMap<>();
        Entity e = new Entity();

        try {
            String sql = """
            SELECT SUM(totaleorerendicontabili) AS totOre, idutente
            FROM registro_completo
            WHERE ruolo = 'DOCENTE'
              AND idprogetti_formativi = :pf
            GROUP BY idutente
        """;

            Query query = e.getEm().createNativeQuery(sql);
            query.setParameter("pf", pf);

            @SuppressWarnings("unchecked")
            List<Object[]> results = query.getResultList();

            for (Object[] row : results) {
                Long idutente = ((Number) row[1]).longValue();
                Long totOre = ((Number) row[0]).longValue();
                result.put(idutente, totOre);
            }

        } catch (Exception ex) {
            LOGAPP.log(Level.SEVERE, "Errore in OreRendicontabiliDocenti", ex);
        } finally {
            e.close();
        }

        return result;
    }

    public Map<Long, Long> OreRendicontabiliAlunni(int pf) {
        Map<Long, Long> result = new HashMap<>();
        Entity e = new Entity();

        try {
            String sql = """
            SELECT SUM(totaleorerendicontabili) AS totOre, idutente
            FROM registro_completo
            WHERE idprogetti_formativi = :pf
              AND ruolo LIKE 'ALLIEVO%'
            GROUP BY idutente
        """;

            Query query = e.getEm().createNativeQuery(sql);
            query.setParameter("pf", pf);

            @SuppressWarnings("unchecked")
            List<Object[]> results = query.getResultList();

            for (Object[] row : results) {
                Long idutente = ((Number) row[1]).longValue();
                Long totOre = ((Number) row[0]).longValue();
                result.put(idutente, totOre);
            }

        } catch (Exception ex) {
            LOGAPP.log(Level.SEVERE, "Errore in OreRendicontabiliAlunni", ex);
        } finally {
            e.close();
        }

        return result;
    }

    public Map<Long, Long> OreRendicontabiliAlunni_faseB(int pf) {
        Map<Long, Long> result = new HashMap<>();
        Entity e = new Entity();

        try {
            if (Utility.demoversion) {
                // Demo version: massimo per idutente e data
                String sql1 = """
                SELECT MAX(totaleorerendicontabili) AS totOre, idutente
                FROM registro_completo
                WHERE fase = 'B' AND ruolo LIKE 'ALLIEVO%'
                  AND idutente IN (
                      SELECT DISTINCT idutente
                      FROM registro_completo
                      WHERE fase = 'B'
                        AND idprogetti_formativi = :pf
                        AND ruolo LIKE 'ALLIEVO%'
                  )
                GROUP BY idutente, data
            """;

                Query query1 = e.getEm().createNativeQuery(sql1);
                query1.setParameter("pf", pf);

                @SuppressWarnings("unchecked")
                List<Object[]> results1 = query1.getResultList();

                for (Object[] row : results1) {
                    Long idutente = ((Number) row[1]).longValue();
                    Long totOre = ((Number) row[0]).longValue();

                    result.merge(idutente, totOre, Long::sum); // somma se già presente
                }

            } else {
                // Versione standard: somma totale per idutente
                String sql2 = """
                SELECT SUM(totaleorerendicontabili) AS totOre, idutente
                FROM registro_completo
                WHERE fase = 'B' AND ruolo LIKE 'ALLIEVO%' AND idprogetti_formativi = :pf
                GROUP BY idutente
            """;

                Query query2 = e.getEm().createNativeQuery(sql2);
                query2.setParameter("pf", pf);

                @SuppressWarnings("unchecked")
                List<Object[]> results2 = query2.getResultList();

                for (Object[] row : results2) {
                    Long idutente = ((Number) row[1]).longValue();
                    Long totOre = ((Number) row[0]).longValue();
                    result.put(idutente, totOre);
                }
            }

        } catch (Exception ex) {
            LOGAPP.log(Level.SEVERE, "Errore in OreRendicontabiliAlunni_faseB", ex);
        } finally {
            e.close();
        }

        return result;
    }

    public Map<Long, Long> OreRendicontabiliAlunni_faseA(int pf) {
        Map<Long, Long> result = new HashMap<>();
        Entity e = new Entity(); 

        try {
            String sql;
            if (Utility.demoversion) {
                sql = """
                SELECT idutente, MAX(totaleorerendicontabili) AS ore
                FROM registro_completo
                WHERE fase = 'A'
                  AND ruolo LIKE 'ALLIEVO%'
                  AND idprogetti_formativi = ?
                GROUP BY idutente, data
            """;
            } else {
                sql = """
                SELECT idutente, SUM(totaleorerendicontabili) AS ore
                FROM registro_completo
                WHERE fase = 'A'
                  AND ruolo LIKE 'ALLIEVO%'
                  AND idprogetti_formativi = ?
                GROUP BY idutente
            """;
            }

            Query query = e.getEm().createNativeQuery(sql);
            query.setParameter(1, pf);

            @SuppressWarnings("unchecked")
            List<Object[]> rows = query.getResultList();

            for (Object[] row : rows) {
                Long idUtente = ((Number) row[0]).longValue();
                Long ore = ((Number) row[1]).longValue();

                if (Utility.demoversion) {
                    result.merge(idUtente, ore, Long::sum);
                } else {
                    result.put(idUtente, ore);
                }
            }

        } catch (Exception ex) {
            LOGAPP.log(Level.SEVERE, "Errore in OreRendicontabiliAlunni_faseA", ex);
        } finally {
            e.close();
        }

        return result;
    }

    public String[] dati_modello5_neet(String idneet, String idsa, String pf) {
        String datafinepercorso = "";
        AtomicLong orefrequenza = new AtomicLong(0L);
        Entity e = new Entity();

        try {
            String sql = """
            SELECT data, totaleorerendicontabili
            FROM registro_completo
            WHERE idutente = :idneet
              AND idprogetti_formativi = :pf
              AND idsoggetti_attuatori = :idsa
              AND ruolo = 'ALLIEVO NEET'
            ORDER BY data
        """;

            Query query = e.getEm().createNativeQuery(sql);
            query.setParameter("idneet", Long.valueOf(idneet));
            query.setParameter("pf", Long.valueOf(pf));
            query.setParameter("idsa", Long.valueOf(idsa));

            @SuppressWarnings("unchecked")
            List<Object[]> results = query.getResultList();

            for (Object[] row : results) {
                java.sql.Date data = (java.sql.Date) row[0];
                Number ore = (Number) row[1];

                datafinepercorso = Utility.sdfITA.format(data);
                orefrequenza.addAndGet(ore.longValue());
            }

        } catch (Exception ex) {
            LOGAPP.log(Level.SEVERE, estraiEccezione(ex));
        } finally {
            e.close();
        }

        return new String[]{datafinepercorso, calcoladurata(orefrequenza.get())};
    }

    public void popolaregistro_B(ProgettiFormativi p, Lezioni_Modelli lm) {
        Entity e = new Entity();
        long durata = new BigDecimal(lm.getLezione_calendario().getOre() * 3600000L).longValue();

        try {
            e.begin();

            // Allievi NEET
            for (Allievi al1 : p.getAllievi()) {
                if (al1.getStatopartecipazione().getId().equals("01") && al1.getGruppo_faseB() == lm.getGruppo_faseB()) {
                    String ins = """
                    INSERT INTO registro_completo (idprogetti_formativi, idsoggetti_attuatori, cip, data, idriunione, numpartecipanti,
                        orainizio, orafine, durata, nud, fase, gruppofaseb, ruolo, cognome, nome, email, orelogin, orelogout,
                        totaleore, totaleorerendicontabili, idutente)
                    VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
                """;

                    Query query = e.getEm().createNativeQuery(ins);
                    query.setParameter(1, p.getId());
                    query.setParameter(2, p.getSoggetto().getId());
                    query.setParameter(3, p.getCip());
                    query.setParameter(4, sdfSQL.format(lm.getGiorno()));
                    query.setParameter(5, "TESTINGID_B" + lm.getGruppo_faseB() + "_" + lm.getLezione_calendario().getLezione());
                    query.setParameter(6, p.getAllievi_ok() + 1);
                    query.setParameter(7, lm.getOrainizio());
                    query.setParameter(8, lm.getOrafine());
                    query.setParameter(9, durata);
                    query.setParameter(10, "GIORNO " + lm.getLezione_calendario().getLezione() + " - " + lm.getLezione_calendario().getUnitadidattica().getCodice());
                    query.setParameter(11, "B");
                    query.setParameter(12, lm.getGruppo_faseB());
                    query.setParameter(13, "ALLIEVO NEET");
                    query.setParameter(14, al1.getCognome());
                    query.setParameter(15, al1.getNome());
                    query.setParameter(16, al1.getEmail());
                    query.setParameter(17, lm.getOrainizio());
                    query.setParameter(18, lm.getOrafine());
                    query.setParameter(19, durata);
                    query.setParameter(20, durata);
                    query.setParameter(21, al1.getId());

                    query.executeUpdate();
                }
            }

            // Docente
            String insDocente = """
            INSERT INTO registro_completo (idprogetti_formativi, idsoggetti_attuatori, cip, data, idriunione, numpartecipanti,
                orainizio, orafine, durata, nud, fase, gruppofaseb, ruolo, cognome, nome, email, orelogin, orelogout,
                totaleore, totaleorerendicontabili, idutente)
            VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
        """;

            Query queryDoc = e.getEm().createNativeQuery(insDocente);
            queryDoc.setParameter(1, p.getId());
            queryDoc.setParameter(2, p.getSoggetto().getId());
            queryDoc.setParameter(3, p.getCip());
            queryDoc.setParameter(4, sdfSQL.format(lm.getGiorno()));
            queryDoc.setParameter(5, "TESTINGID_B" + lm.getGruppo_faseB() + "_" + lm.getLezione_calendario().getLezione());
            queryDoc.setParameter(6, p.getAllievi_ok() + 1);
            queryDoc.setParameter(7, lm.getOrainizio());
            queryDoc.setParameter(8, lm.getOrafine());
            queryDoc.setParameter(9, durata);
            queryDoc.setParameter(10, "GIORNO " + lm.getLezione_calendario().getLezione() + " - " + lm.getLezione_calendario().getUnitadidattica().getCodice());
            queryDoc.setParameter(11, "B");
            queryDoc.setParameter(12, lm.getGruppo_faseB());
            queryDoc.setParameter(13, "DOCENTE");
            queryDoc.setParameter(14, lm.getDocente().getCognome());
            queryDoc.setParameter(15, lm.getDocente().getNome());
            queryDoc.setParameter(16, lm.getDocente().getEmail());
            queryDoc.setParameter(17, lm.getOrainizio());
            queryDoc.setParameter(18, lm.getOrafine());
            queryDoc.setParameter(19, durata);
            queryDoc.setParameter(20, durata);
            queryDoc.setParameter(21, lm.getDocente().getId());

            queryDoc.executeUpdate();

            e.commit();

        } catch (Exception ex) {
            e.rollBack();
            LOGAPP.log(Level.SEVERE, estraiEccezione(ex));
        } finally {
            e.close();
        }
    }

    public void popolaregistro_A(ProgettiFormativi p, Lezioni_Modelli lm) {
        Entity e = new Entity();
        long durata = new BigDecimal(lm.getLezione_calendario().getOre() * 3600000L).longValue();

        try {
            e.begin();

            // Allievi NEET
            for (Allievi al1 : p.getAllievi()) {
                if (al1.getStatopartecipazione().getId().equals("01")) {
                    String ins = """
                    INSERT INTO registro_completo (
                        idprogetti_formativi, idsoggetti_attuatori, cip, data, idriunione, numpartecipanti,
                        orainizio, orafine, durata, nud, fase, gruppofaseb, ruolo, cognome, nome, email,
                        orelogin, orelogout, totaleore, totaleorerendicontabili, idutente
                    ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
                """;

                    Query query = e.getEm().createNativeQuery(ins);
                    query.setParameter(1, p.getId());
                    query.setParameter(2, p.getSoggetto().getId());
                    query.setParameter(3, p.getCip());
                    query.setParameter(4, sdfSQL.format(lm.getGiorno()));
                    query.setParameter(5, "TESTINGID_" + lm.getLezione_calendario().getLezione());
                    query.setParameter(6, p.getAllievi_ok() + 1);
                    query.setParameter(7, lm.getOrainizio());
                    query.setParameter(8, lm.getOrafine());
                    query.setParameter(9, durata);
                    query.setParameter(10, "GIORNO " + lm.getLezione_calendario().getLezione()
                            + " - " + lm.getLezione_calendario().getUnitadidattica().getCodice());
                    query.setParameter(11, "A");
                    query.setParameter(12, 1);
                    query.setParameter(13, "ALLIEVO NEET");
                    query.setParameter(14, al1.getCognome());
                    query.setParameter(15, al1.getNome());
                    query.setParameter(16, al1.getEmail());
                    query.setParameter(17, lm.getOrainizio());
                    query.setParameter(18, lm.getOrafine());
                    query.setParameter(19, durata);
                    query.setParameter(20, durata);
                    query.setParameter(21, al1.getId());

                    query.executeUpdate();
                }
            }

            // Docente
            String insDocente = """
            INSERT INTO registro_completo (
                idprogetti_formativi, idsoggetti_attuatori, cip, data, idriunione, numpartecipanti,
                orainizio, orafine, durata, nud, fase, gruppofaseb, ruolo, cognome, nome, email,
                orelogin, orelogout, totaleore, totaleorerendicontabili, idutente
            ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
        """;

            Query queryDoc = e.getEm().createNativeQuery(insDocente);
            queryDoc.setParameter(1, p.getId());
            queryDoc.setParameter(2, p.getSoggetto().getId());
            queryDoc.setParameter(3, p.getCip());
            queryDoc.setParameter(4, sdfSQL.format(lm.getGiorno()));
            queryDoc.setParameter(5, "TESTINGID_" + lm.getLezione_calendario().getLezione());
            queryDoc.setParameter(6, p.getAllievi_ok() + 1);
            queryDoc.setParameter(7, lm.getOrainizio());
            queryDoc.setParameter(8, lm.getOrafine());
            queryDoc.setParameter(9, durata);
            queryDoc.setParameter(10, "GIORNO " + lm.getLezione_calendario().getLezione()
                    + " - " + lm.getLezione_calendario().getUnitadidattica().getCodice());
            queryDoc.setParameter(11, "A");
            queryDoc.setParameter(12, 1);
            queryDoc.setParameter(13, "DOCENTE");
            queryDoc.setParameter(14, lm.getDocente().getCognome());
            queryDoc.setParameter(15, lm.getDocente().getNome());
            queryDoc.setParameter(16, lm.getDocente().getEmail());
            queryDoc.setParameter(17, lm.getOrainizio());
            queryDoc.setParameter(18, lm.getOrafine());
            queryDoc.setParameter(19, durata);
            queryDoc.setParameter(20, durata);
            queryDoc.setParameter(21, lm.getDocente().getId());

            queryDoc.executeUpdate();

            e.commit();
        } catch (Exception ex) {
            e.rollBack();
            LOGAPP.log(Level.SEVERE, estraiEccezione(ex));
        } finally {
            e.close();
        }
    }

    public void svuotaregistroB(String idpr) {
        if (!test) {
            return;
        }
        Entity e = new Entity();
        try {
            e.begin();
            String del = "DELETE FROM registro_completo WHERE fase = 'B' AND idprogetti_formativi = :idpr";
            Query query = e.getEm().createNativeQuery(del);
            query.setParameter("idpr", Long.valueOf(idpr));
            query.executeUpdate();
            e.commit();
        } catch (NumberFormatException ex) {
            e.rollBack();
            LOGAPP.log(Level.SEVERE, estraiEccezione(ex));
        } finally {
            e.close();
        }
    }

    public void svuotaregistro(String idpr) {
        if (!test) {
            return;
        }
        Entity e = new Entity();
        try {
            e.begin();
            String del = "DELETE FROM registro_completo WHERE idprogetti_formativi = :idpr";
            Query query = e.getEm().createNativeQuery(del);
            query.setParameter("idpr", Long.valueOf(idpr));
            query.executeUpdate();
            e.commit();
        } catch (NumberFormatException ex) {
            e.rollBack();
            LOGAPP.log(Level.SEVERE, estraiEccezione(ex));
        } finally {
            e.close();
        }
    }

    public List<Registro_completo> registro_modello6(String idpr) {
        List<Registro_completo> registro = new ArrayList<>();
        Entity e = new Entity();
        try {
            String sql = "SELECT * FROM registro_completo WHERE idprogetti_formativi = :idpr "
                    + "GROUP BY ruolo,idutente,data ORDER BY data";
            Query query = e.getEm().createNativeQuery(sql, Registro_completo.class);
            query.setParameter("idpr", Long.valueOf(idpr));
            registro = query.getResultList();
        } catch (NumberFormatException ex) {
            LOGAPP.log(Level.SEVERE, estraiEccezione(ex));
        } finally {
            e.close();
        }
        return registro;
    }

    public List<Item> area_qualificazione() {
        List<Item> out = new ArrayList<>();
        Entity e = new Entity();
        try {
            String sql = "SELECT * FROM qualificazione_rc";
            Query query = e.getEm().createNativeQuery(sql);
            List<Object[]> results = query.getResultList();
            for (Object[] row : results) {
                out.add(new Item(((Number) row[0]).intValue(), (String) row[1]));
            }
        } catch (Exception ex) {
            LOGAPP.log(Level.SEVERE, estraiEccezione(ex));
        } finally {
            e.close();
        }
        return out;
    }

    public List<Item> inquadramento() {
        List<Item> out = new ArrayList<>();
        Entity e = new Entity();
        try {
            String sql = "SELECT * FROM inquadramento_rc";
            Query query = e.getEm().createNativeQuery(sql);
            List<Object[]> results = query.getResultList();
            for (Object[] row : results) {
                out.add(new Item(((Number) row[0]).intValue(), (String) row[1]));
            }
        } catch (Exception ex) {
            LOGAPP.log(Level.SEVERE, estraiEccezione(ex));
        } finally {
            e.close();
        }
        return out;
    }

    public ArrayList<Item> attivita_docenti() {
        ArrayList<Item> out = new ArrayList<>();
        Entity e = new Entity();
        try {
            String sql = "SELECT * FROM attivita_docenti_rc";
            Query query = e.getEm().createNativeQuery(sql);
            List<Object[]> results = query.getResultList();
            for (Object[] row : results) {
                out.add(new Item(((Number) row[0]).intValue(), (String) row[1]));
            }
        } catch (Exception ex) {
            LOGAPP.log(Level.SEVERE, estraiEccezione(ex));
        } finally {
            e.close();
        }
        return out;
    }

    public ArrayList<Item> disponibilita() {
        ArrayList<Item> out = new ArrayList<>();
        Entity e = new Entity();
        try {
            String sql = "SELECT * FROM disponibilita_rc";
            Query query = e.getEm().createNativeQuery(sql);
            List<Object[]> results = query.getResultList();
            for (Object[] row : results) {
                out.add(new Item(((Number) row[0]).intValue(), (String) row[1]));
            }
        } catch (Exception ex) {
            LOGAPP.log(Level.SEVERE, estraiEccezione(ex));
        } finally {
            e.close();
        }
        return out;
    }

    public boolean isVisible(String gruppo, String page) {
        Entity e = new Entity();
        try {
            String jpql = "SELECT p.permessi FROM Pagina p WHERE p.nome = :page AND p.permessi LIKE :gruppo";
            TypedQuery<String> query = e.getEm().createQuery(jpql, String.class);
            query.setParameter("page", page);
            query.setParameter("gruppo", "%" + gruppo + "%");
            List<String> results = query.getResultList();
            return !results.isEmpty();
        } catch (Exception ex) {
            LOGAPP.log(Level.SEVERE, estraiEccezione(ex));
        } finally {
            e.close();
        }
        return false;
    }

    public ArrayList<Item> fontifin() {
        ArrayList<Item> out = new ArrayList<>();
        Entity e = new Entity();
        try {
            String sql = "SELECT * FROM fontifin_rc";
            Query query = e.getEm().createNativeQuery(sql);
            List<Object[]> results = query.getResultList();

            for (Object[] row : results) {
                out.add(new Item(((Number) row[0]).intValue(), (String) row[1]));
            }
        } catch (Exception ex) {
            LOGAPP.log(Level.SEVERE, estraiEccezione(ex));
        } finally {
            e.close();
        }
        return out;
    }

    public String[] sa_cip(int idpr) {
        Entity e = new Entity();
        try {
            // Recupera cip e id soggetto attuatore dal progetto formativo
            String sql0 = "SELECT cip, idsoggetti_attuatori FROM progetti_formativi WHERE idprogetti_formativi = " + idpr;
            Query q0 = e.getEm().createNativeQuery(sql0);
            List<Object[]> res0 = q0.getResultList();

            if (!res0.isEmpty()) {
                Object[] row0 = res0.get(0);
                String cip = (String) row0[0];
                Integer idsa = ((Number) row0[1]).intValue();

                // Recupera ragione sociale del soggetto attuatore
                String sql1 = "SELECT ragionesociale FROM soggetti_attuatori WHERE idsoggetti_attuatori = " + idsa;
                Query q1 = e.getEm().createNativeQuery(sql1);
                List<Object> res1 = q1.getResultList();

                if (!res1.isEmpty()) {
                    String ragioneSociale = ((String) res1.get(0)).trim().toUpperCase();
                    return new String[]{ragioneSociale, cip, String.valueOf(idsa)};
                }
            }
        } catch (Exception ex) {
            LOGAPP.log(Level.SEVERE, estraiEccezione(ex));
        } finally {
            e.close();
        }
        return null;
    }

    public List<Utenti> list_Allievi_noAccento(int idpr) {
        List<Utenti> out = new ArrayList<>();
        Entity en = new Entity();
        try {
            String sql = "SELECT idallievi, nome, cognome, codicefiscale, email "
                    + "FROM allievi WHERE id_statopartecipazione='01' AND idprogetti_formativi = " + idpr;
            Query q = en.getEm().createNativeQuery(sql);
            List<Object[]> results = q.getResultList();

            for (Object[] row : results) {
                int id = ((Number) row[0]).intValue();
                String cognome = stripAccents(((String) row[2]).toUpperCase().trim());
                String nome = stripAccents(((String) row[1]).toUpperCase().trim());
                String cf = ((String) row[3]).toUpperCase();
                String ruolo = "ALLIEVO NEET";
                String email = ((String) row[4]).toLowerCase();

                out.add(new Utenti(id, cognome, nome, cf, ruolo, email));
            }
        } catch (Exception ex) {
            LOGAPP.log(Level.SEVERE, estraiEccezione(ex));
        } finally {
            en.close();
        }
        return out;
    }

    public List<Utenti> list_Allievi_noAccento(int idpr, int gruppo) {
        List<Utenti> out = new ArrayList<>();
        Entity en = new Entity();
        try {
            String sql = "SELECT idallievi, nome, cognome, codicefiscale, email "
                    + "FROM allievi WHERE id_statopartecipazione='01' AND idprogetti_formativi = " + idpr
                    + " AND gruppo_faseB = " + gruppo;
            Query q = en.getEm().createNativeQuery(sql);
            List<Object[]> results = q.getResultList();

            for (Object[] row : results) {
                int id = ((Number) row[0]).intValue();
                String cognome = stripAccents(((String) row[2]).toUpperCase().trim());
                String nome = stripAccents(((String) row[1]).toUpperCase().trim());
                String cf = ((String) row[3]).toUpperCase();
                String ruolo = "ALLIEVO NEET";
                String email = ((String) row[4]).toLowerCase();

                out.add(new Utenti(id, cognome, nome, cf, ruolo, email));
            }
        } catch (Exception ex) {
            LOGAPP.log(Level.SEVERE, estraiEccezione(ex));
        } finally {
            en.close();
        }
        return out;
    }

    public List<Utenti> list_Allievi(int idpr) {
        List<Utenti> out = new ArrayList<>();
        Entity en = new Entity();
        try {
            String sql = "SELECT idallievi, nome, cognome, codicefiscale, email "
                    + "FROM allievi WHERE id_statopartecipazione='01' AND idprogetti_formativi = " + idpr;
            Query q = en.getEm().createNativeQuery(sql);
            List<Object[]> results = q.getResultList();

            for (Object[] row : results) {
                int id = ((Number) row[0]).intValue();
                String cognome = ((String) row[2]).toUpperCase().trim();
                String nome = ((String) row[1]).toUpperCase().trim();
                String cf = ((String) row[3]).toUpperCase();
                String ruolo = "ALLIEVO NEET";
                String email = ((String) row[4]).toLowerCase();

                out.add(new Utenti(id, cognome, nome, cf, ruolo, email));
            }
        } catch (Exception ex) {
            LOGAPP.log(Level.SEVERE, estraiEccezione(ex));
        } finally {
            en.close();
        }
        return out;
    }

    public List<Utenti> list_Docenti(int idpr) {
        List<Utenti> out = new ArrayList<>();
        Entity en = new Entity();
        try {
            String sql = "SELECT iddocenti, nome, cognome, codicefiscale, email "
                    + "FROM docenti WHERE iddocenti IN "
                    + "(SELECT iddocenti FROM progetti_docenti WHERE idprogetti_formativi = " + idpr + ")";
            Query q = en.getEm().createNativeQuery(sql);
            List<Object[]> results = q.getResultList();

            for (Object[] row : results) {
                int id = ((Number) row[0]).intValue();
                String cognome = ((String) row[2]).toUpperCase().trim();
                String nome = ((String) row[1]).toUpperCase().trim();
                String cf = ((String) row[3]).toUpperCase();
                String ruolo = "DOCENTE";
                String email = ((String) row[4]).toLowerCase();

                out.add(new Utenti(id, cognome, nome, cf, ruolo, email));
            }
        } catch (Exception ex) {
            LOGAPP.log(Level.SEVERE, estraiEccezione(ex));
        } finally {
            en.close();
        }
        return out;
    }

    public List<Utenti> list_Docenti_noAccento(int idpr) {
        List<Utenti> out = new ArrayList<>();
        Entity en = new Entity();
        try {
            String sql = "SELECT iddocenti, nome, cognome, codicefiscale, email "
                    + "FROM docenti WHERE iddocenti IN "
                    + "(SELECT iddocenti FROM progetti_docenti WHERE idprogetti_formativi = " + idpr + ")";
            Query q = en.getEm().createNativeQuery(sql);
            List<Object[]> results = q.getResultList();

            for (Object[] row : results) {
                int id = ((Number) row[0]).intValue();
                String cognome = stripAccents(((String) row[2]).toUpperCase().trim());
                String nome = stripAccents(((String) row[1]).toUpperCase().trim());
                String cf = ((String) row[3]).toUpperCase();
                String ruolo = "DOCENTE";
                String email = ((String) row[4]).toLowerCase();

                out.add(new Utenti(id, cognome, nome, cf, ruolo, email));
            }
        } catch (Exception ex) {
            LOGAPP.log(Level.SEVERE, estraiEccezione(ex));
        } finally {
            en.close();
        }
        return out;
    }

    public boolean insertRegistro(rc.so.util.Registro_completo rc) {
        Entity en = new Entity();
        try {
            String insert = "INSERT INTO registro_completo (idprogetti_formativi, idsoggetti_attuatori, cip, data, "
                    + "idriunione, numpartecipanti, orainizio, orafine, durata, nud, "
                    + "fase, gruppofaseb, ruolo, cognome, nome, email, orelogin, orelogout, "
                    + "totaleore, totaleorerendicontabili, idutente) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            Query q = en.getEm().createNativeQuery(insert);
            q.setParameter(1, rc.getIdprogetti_formativi());
            q.setParameter(2, rc.getIdsoggetti_attuatori());
            q.setParameter(3, rc.getCip());
            q.setParameter(4, rc.getData().toString(Utility.patternSql));

            q.setParameter(5, rc.getIdriunione());
            q.setParameter(6, rc.getNumpartecipanti());
            q.setParameter(7, rc.getOrainizio());
            q.setParameter(8, rc.getOrafine());
            q.setParameter(9, rc.getDurata());
            q.setParameter(10, rc.getNud());

            q.setParameter(11, rc.getFase());
            q.setParameter(12, rc.getGruppofaseb());
            q.setParameter(13, rc.getRuolo());
            q.setParameter(14, rc.getCognome());
            q.setParameter(15, rc.getNome());
            q.setParameter(16, rc.getEmail());
            q.setParameter(17, rc.getOrelogin());
            q.setParameter(18, rc.getOrelogout());

            q.setParameter(19, rc.getTotaleore());
            q.setParameter(20, rc.getTotaleorerendicontabili());
            q.setParameter(21, rc.getIdutente());

            q.executeUpdate();
            return true;
        } catch (Exception ex) {
            LOGAPP.log(Level.SEVERE, estraiEccezione(ex));
        } finally {
            en.close();
        }
        return false;
    }

    public List<Presenze_Lezioni_Allievi> presenze_fad(Long idallievo) {
        List<Presenze_Lezioni_Allievi> pla = new ArrayList<>();
        Entity en = new Entity();
        try {
            List<Registro_completo> results = en.getEm().createQuery(
                    "SELECT r FROM Registro_completo r WHERE r.idutente = :id AND r.ruolo = 'ALLIEVO'",
                    Registro_completo.class)
                    .setParameter("id", idallievo)
                    .getResultList();

            for (Registro_completo r : results) {
                Presenze_Lezioni_Allievi pl = new Presenze_Lezioni_Allievi();

                pl.setDatalezione(r.getData().toDate());

                pl.setConvalidata(true);
                pl.setDurata(r.getTotaleore());
                pl.setDurataconvalidata(r.getTotaleorerendicontabili());
                pl.setOrainizio(r.getOrelogin());
                pl.setOrafine(r.getOrelogout());

                pla.add(pl);
            }

        } catch (Exception ex) {
            LOGAPP.log(Level.SEVERE, estraiEccezione(ex));
        }
        return pla;
    }

    public Object getC() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
