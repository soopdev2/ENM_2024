/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rc.so.util;

import jakarta.persistence.TypedQuery;
import static rc.so.db.Action.insertTR;
import rc.so.db.Database;
import static rc.so.util.Utility.estraiEccezione;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author rcosco
 */
public class FaseA {

    public String host;

    public FaseA(boolean test, boolean neet) {
        if (neet) {
            this.host = "clustermicrocredito.cluster-c6m6yfqeypv3.eu-south-1.rds.amazonaws.com:3306/enm_gestione_neet_prod";
            if (test) {
                this.host = "clustermicrocredito.cluster-c6m6yfqeypv3.eu-south-1.rds.amazonaws.com:3306/enm_gestione_neet";
            }
        } else {
            this.host = "clustermicrocredito.cluster-c6m6yfqeypv3.eu-south-1.rds.amazonaws.com:3306/enm_gestione_dd_prod";
            if (test) {
                this.host = "clustermicrocredito.cluster-c6m6yfqeypv3.eu-south-1.rds.amazonaws.com:3306/enm_gestione_dd";
            }
        }
    }

//    public static void main(String[] args) {
//        FaseA fa = new FaseA(false);
//        
//        List<Lezione> l = fa.calcolaegeneraregistrofasea(82, fa.getHost(), false, false,false);
//        
//        File f = fa.registro_aula_FaseA(82, fa.getHost(), false, l);
//
//    }
    public List<Lezione> calcolaegeneraregistrofasea(int idpr, String host, boolean printing, boolean save, boolean today) {
        List<Lezione> calendar = new ArrayList<>();
        try {
            List<Lezione> calendartemp;

            Database db1 = new Database(false);

            // JPQL equivalente alla query SQL originale
            String jpql = "SELECT new Lezione(lc.lezione, lm.id_docente, lm.giorno, lm.orarioStart, lm.orarioEnd, "
                    + "ud.codice, lc.ore, 1, '') "
                    + "FROM LezioniModelli lm "
                    + "JOIN lm.modelloProgetto mp "
                    + "JOIN lm.lezioneCalendario lc "
                    + "JOIN lc.unitaDidattica ud "
                    + "WHERE mp.progetto.id = :idpr AND ud.fase = 'Fase A' "
                    + "ORDER BY lc.lezione, lm.orarioStart";

            TypedQuery<Lezione> query = db1.getEm().createQuery(jpql, Lezione.class)
                    .setParameter("idpr", idpr);

            calendartemp = query.getResultList();

            db1.closeDB();

            // Logica di combinazione lezioni e calcolo ore rimane invariata
            for (int i = 0; i < calendartemp.size(); i++) {
                Lezione cal = calendartemp.get(i);
                Lezione cal2 = (i + 1 < calendartemp.size()) ? calendartemp.get(i + 1) : null;
                Lezione cal3 = (i - 1 >= 0) ? calendartemp.get(i - 1) : null;

                boolean hasnext = cal2 != null;
                if (hasnext) {
                    if (cal.getGiorno().equals(cal2.getGiorno())) {
                        List<Integer> doc1 = new ArrayList<>();
                        doc1.addAll(cal.getDocente());
                        cal2.getDocente().forEach(d1 -> {
                            if (!doc1.contains(d1)) {
                                doc1.add(d1);
                            }
                        });
                        double ore = Double.parseDouble(cal.getOre()) + Double.parseDouble(cal2.getOre());
                        calendar.add(new Lezione(cal.getId(), doc1,
                                cal.getGiorno(), cal.getStart(), cal2.getEnd(),
                                cal.getCodiceud() + "_" + cal2.getCodiceud(),
                                Utility.doubleformat.format(ore), cal.getGruppo(), ""));
                    } else {
                        if (cal3 == null || !cal3.getGiorno().equals(cal.getGiorno())) {
                            calendar.add(cal);
                        }
                    }
                } else {
                    if (i == 0) {
                        calendar.add(cal);
                    } else {
                        if (!cal.getGiorno().equals(cal3.getGiorno())) {
                            calendar.add(cal);
                        }
                    }
                }
            }

        } catch (Exception ex) {
            insertTR("E", "SERVICE", estraiEccezione(ex));
        }
        return calendar;
    }

    public String getHost() {
        return host;
    }

    public void setHost(String host) {
        this.host = host;
    }

}
