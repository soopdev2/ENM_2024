/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rc.so.util;

import com.itextpdf.barcodes.BarcodeQRCode;
import com.itextpdf.io.font.constants.StandardFonts;
import com.itextpdf.kernel.colors.Color;
import com.itextpdf.kernel.colors.DeviceRgb;
import com.itextpdf.kernel.font.PdfFont;
import com.itextpdf.kernel.font.PdfFontFactory;
import com.itextpdf.kernel.geom.PageSize;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfReader;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.kernel.utils.PdfMerger;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.Style;
import com.itextpdf.layout.borders.Border;
import com.itextpdf.layout.element.AreaBreak;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.properties.AreaBreakType;
import com.itextpdf.layout.properties.TextAlignment;
import com.itextpdf.layout.properties.UnitValue;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import static rc.so.db.Action.insertTR;
import rc.so.db.Database;
import rc.so.domain.User;
import static rc.so.util.Utility.calcoladurata;
import static rc.so.util.Utility.checkPDF;
import static rc.so.util.Utility.estraiEccezione;
import static rc.so.util.Utility.formatStringtoStringDateSQL;
import static rc.so.util.Utility.patternITA;
import static rc.so.util.Utility.patternid;
import static rc.so.util.Utility.printbarcode;
import static rc.so.util.Utility.sanitizeFile;
import static rc.so.util.Utility.timestamp;
import static rc.so.util.Utility.timestampITAcomplete;
import java.io.File;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.joda.time.DateTime;
import rc.so.domain.DocumentiPrg;
import rc.so.domain.ProgettiFormativi;
import rc.so.domain.TipoDoc;

/**
 *
 * @author rcosco
 */
public class Complessivo {

    public String host;

    public Complessivo(String host) {
        this.host = host;
    }

    public File registro_complessivo(int idpr, String host, List<Lezione> fa, List<Lezione> fb, boolean save) {
        try {

            Database db1 = new Database(false);
            String linkpiattaforma = db1.getPathtemp("dominio");
            String[] datisa = db1.sa_cip(idpr);
            String path_destinazione = db1.getPathtemp("pathDocSA_Prg").replace("@rssa",
                    datisa[2]).replace("@folder",
                            String.valueOf(idpr));
            DateTime adesso = new DateTime();
            String now = adesso.toString(timestampITAcomplete);
            String now0 = adesso.toString(timestamp);
            String now1 = adesso.toString(patternid);
            String pathtemp = db1.getPathtemp("pathTemp");
            // dati pdf
            Color lightgrey = new DeviceRgb(242, 242, 242);
            PdfFont fontbold = PdfFontFactory.createFont(StandardFonts.HELVETICA_BOLD);
            Style bold = new Style();
            bold.setFont(fontbold).setFontSize(11);
            PdfFont fontnormal = PdfFontFactory.createFont(StandardFonts.HELVETICA);
            Style normal = new Style();
            normal.setFont(fontnormal).setFontSize(10);

            // CREA PDF REPORT
            File out00 = new File(pathtemp + now0 + "reportcomplessivo_" + idpr + ".pdf");
            File out0 = sanitizeFile(out00);
            PdfWriter pw0 = new PdfWriter(out0);
            PdfDocument pdfDoc = new PdfDocument(pw0);
            pdfDoc.setDefaultPageSize(PageSize.A4.rotate());
            Document doc = new Document(pdfDoc);
            AtomicInteger indice = new AtomicInteger(1);

            fa.forEach(cal -> {

                List<Registro_completo> registro = new ArrayList<>();
                Table table = new Table(UnitValue.createPercentArray(8)).useAllAvailableWidth();
                try {

                    String day = cal.getGiorno();

                    // stessa logica e stesso SQL, ma usiamo l'EntityManager
                    String jpql = "SELECT r FROM Registro_completo r "
                            + "WHERE r.idprogetti_formativi = :idpr "
                            + "AND r.data = :day "
                            + "AND r.fase = 'A' "
                            + "ORDER BY r.ruolo DESC, r.cognome ASC, r.nome ASC";

                    TypedQuery<Registro_completo> query = db1.getEm()
                            .createQuery(jpql, Registro_completo.class)
                            .setParameter("idpr", idpr)
                            .setParameter("day", java.sql.Date.valueOf(day));

                    registro = query.getResultList();

                    Cell cell0 = new Cell(1, 8);
                    cell0.add(new Paragraph("YES I START UP – Formazione per l'Avvio d'Impresa").addStyle(bold));
                    cell0.add(new Paragraph("Edizione 2021/2022").addStyle(bold));
                    cell0.add(new Paragraph("Misura 7.1 (PON IOG 2014-2020)").addStyle(bold));
                    cell0.add(new Paragraph("CUP E51G21000000006").addStyle(bold));

                    cell0.setTextAlignment(TextAlignment.CENTER);
                    table.addCell(cell0);

                    Cell cell = new Cell(1, 8);
                    cell.add(new Paragraph(" ").addStyle(normal));
                    cell.setTextAlignment(TextAlignment.CENTER);
                    cell.setBorder(Border.NO_BORDER);
                    table.addCell(cell);
                    cell = new Cell(1, 8);
                    cell.add(new Paragraph(" ").addStyle(normal));
                    cell.setTextAlignment(TextAlignment.CENTER);
                    cell.setBorder(Border.NO_BORDER);
                    table.addCell(cell);
                    cell = new Cell();
                    cell.add(new Paragraph("SOGGETTO ESECUTORE").addStyle(bold));
                    table.addCell(cell);
                    cell = new Cell();
                    cell.add(new Paragraph(datisa[0]).addStyle(normal));
                    cell.setBackgroundColor(lightgrey);
                    table.addCell(cell);
                    cell = new Cell();
                    cell.add(new Paragraph("CIP").addStyle(bold));
                    table.addCell(cell);
                    cell = new Cell();
                    cell.add(new Paragraph(datisa[1]).addStyle(normal));
                    cell.setBackgroundColor(lightgrey);
                    table.addCell(cell);

                    if (!registro.isEmpty()) {

                        Registro_completo primo = registro.get(0);
                        cell = new Cell();
                        cell.add(new Paragraph("DATA").addStyle(bold));
                        table.addCell(cell);
                        cell = new Cell();
                        cell.add(new Paragraph(primo.getData().toString(patternITA)).addStyle(normal));
                        cell.setBackgroundColor(lightgrey);
                        table.addCell(cell);
                        cell = new Cell();
                        cell.add(new Paragraph("ID RIUNIONE").addStyle(bold));
                        table.addCell(cell);
                        cell = new Cell();
                        cell.add(new Paragraph(primo.getIdriunione()).addStyle(normal));
                        cell.setBackgroundColor(lightgrey);
                        table.addCell(cell);
                        cell = new Cell();
                        cell.add(new Paragraph("N. PARTECIPANTI").addStyle(bold));
                        table.addCell(cell);
                        cell = new Cell();
                        cell.add(new Paragraph("ORA INIZIO").addStyle(bold));
                        table.addCell(cell);
                        cell = new Cell();
                        cell.add(new Paragraph("ORA FINE").addStyle(bold));
                        table.addCell(cell);
                        cell = new Cell();
                        cell.add(new Paragraph("DURATA").addStyle(bold));
                        table.addCell(cell);
                        cell = new Cell(1, 2);
                        cell.add(new Paragraph("N.UD - FASE A").addStyle(bold));
                        table.addCell(cell);
                        cell = new Cell(1, 2);
                        cell.add(new Paragraph(" ").addStyle(bold));
                        cell.setBorderRight(Border.NO_BORDER);
                        cell.setBorderBottom(Border.NO_BORDER);
                        table.addCell(cell);

                        cell = new Cell();
                        cell.add(new Paragraph(String.valueOf(primo.getNumpartecipanti())).addStyle(normal));
                        cell.setBackgroundColor(lightgrey);
                        cell.setTextAlignment(TextAlignment.CENTER);
                        table.addCell(cell);
                        cell = new Cell();
                        cell.add(new Paragraph(primo.getOrainizio()).addStyle(normal));
                        cell.setBackgroundColor(lightgrey);
                        cell.setTextAlignment(TextAlignment.CENTER);
                        table.addCell(cell);
                        cell = new Cell();
                        cell.add(new Paragraph(primo.getOrafine()).addStyle(normal));
                        cell.setBackgroundColor(lightgrey);
                        cell.setTextAlignment(TextAlignment.CENTER);
                        table.addCell(cell);
                        cell = new Cell();
                        cell.add(new Paragraph(calcoladurata(primo.getDurata())).addStyle(normal));
                        cell.setBackgroundColor(lightgrey);
                        cell.setTextAlignment(TextAlignment.CENTER);
                        table.addCell(cell);
                        cell = new Cell(1, 2);
                        cell.add(new Paragraph(primo.getNud()).addStyle(normal));
                        cell.setBackgroundColor(lightgrey);
                        cell.setTextAlignment(TextAlignment.CENTER);
                        table.addCell(cell);
                        cell = new Cell(1, 2);
                        cell.add(new Paragraph(" ").addStyle(normal));
                        cell.setTextAlignment(TextAlignment.CENTER);
                        cell.setBorderRight(Border.NO_BORDER);
                        cell.setBorderTop(Border.NO_BORDER);
                        cell.setBorderBottom(Border.NO_BORDER);
                        table.addCell(cell);
                        cell = new Cell(1, 8);
                        cell.add(new Paragraph(" ").addStyle(normal));
                        cell.setTextAlignment(TextAlignment.CENTER);
                        cell.setBorder(Border.NO_BORDER);
                        table.addCell(cell);

                        Cell cel2 = new Cell();
                        cel2.add(new Paragraph("COGNOME").addStyle(bold));
                        table.addCell(cel2);
                        cel2 = new Cell();
                        cel2.add(new Paragraph("NOME").addStyle(bold));
                        table.addCell(cel2);
                        cel2 = new Cell();
                        cel2.add(new Paragraph("RUOLO").addStyle(bold));
                        table.addCell(cel2);
                        cel2 = new Cell();
                        cel2.add(new Paragraph("EMAIL").addStyle(bold));
                        table.addCell(cel2);
                        cel2 = new Cell();
                        cel2.add(new Paragraph("ORA DI ENTRATA (LOGIN)").addStyle(bold));
                        table.addCell(cel2);
                        cel2 = new Cell();
                        cel2.add(new Paragraph("ORA DI USCITA (LOGOUT)").addStyle(bold));
                        table.addCell(cel2);
                        cel2 = new Cell();
                        cel2.add(new Paragraph("TOTALE ORE").addStyle(bold));
                        table.addCell(cel2);
                        cel2 = new Cell();
                        cel2.add(new Paragraph("TOTALE ORE RENDICONTABILI").addStyle(bold));
                        table.addCell(cel2);

                        registro.forEach(r1 -> {
                            Cell cel3 = new Cell();
                            cel3.add(new Paragraph(r1.getCognome()).addStyle(normal));
                            table.addCell(cel3);
                            cel3 = new Cell();
                            cel3.add(new Paragraph(r1.getNome()).addStyle(normal));
                            table.addCell(cel3);
                            cel3 = new Cell();
                            cel3.add(new Paragraph(r1.getRuolo()).addStyle(normal));
                            table.addCell(cel3);
                            cel3 = new Cell();
                            cel3.add(new Paragraph(r1.getEmail()).addStyle(normal));
                            table.addCell(cel3);
                            cel3 = new Cell();
                            cel3.add(new Paragraph(r1.getOrelogin()).addStyle(normal));
                            table.addCell(cel3);
                            cel3 = new Cell();
                            cel3.add(new Paragraph(r1.getOrelogout()).addStyle(normal));
                            table.addCell(cel3);
                            cel3 = new Cell();
                            cel3.add(new Paragraph(calcoladurata(r1.getTotaleore())).addStyle(normal));
                            table.addCell(cel3);
                            cel3 = new Cell();
                            cel3.add(new Paragraph(calcoladurata(r1.getTotaleorerendicontabili())).addStyle(normal));
                            table.addCell(cel3);
                        });
                    } else {
                        cell = new Cell();
                        cell.add(new Paragraph("DATA").addStyle(bold));
                        table.addCell(cell);
                        cell = new Cell();
                        cell.add(new Paragraph(formatStringtoStringDateSQL(day)).addStyle(normal));
                        cell.setBackgroundColor(lightgrey);
                        table.addCell(cell);
                        cell = new Cell(1, 2);
                        cell.add(new Paragraph("NESSUNA LEZIONE TROVATA").addStyle(bold));
                        table.addCell(cell);
                    }
                } catch (Exception ex) {
                    insertTR("E", "SERVICE", estraiEccezione(ex));
                }
                doc.add(table);
                if (indice.get() < fa.size()) {
                    doc.add(new AreaBreak(AreaBreakType.NEXT_PAGE));
                }
                indice.addAndGet(1);

            });
            doc.add(new AreaBreak(AreaBreakType.NEXT_PAGE));
            AtomicInteger indice1 = new AtomicInteger(1);
            fb.forEach(cal -> {
                List<Registro_completo> registro = new ArrayList<>();
                Table table = new Table(UnitValue.createPercentArray(8)).useAllAvailableWidth();
                try {
                    String day = cal.getGiorno();
                    String sql = "SELECT * FROM registro_completo WHERE idprogetti_formativi = " + idpr
                            + " AND data = '" + day
                            + "' AND fase='B' AND gruppofaseb = '" + cal.getGruppo()
                            + "' ORDER BY ruolo DESC,cognome ASC,nome ASC";

                    TypedQuery<Registro_completo> query = db1.getEm()
                            .createQuery(sql, Registro_completo.class)
                            .setParameter("idpr", idpr)
                            .setParameter("day", java.sql.Date.valueOf(day));

                    registro = query.getResultList();

                    Cell cell0 = new Cell(1, 8);
                    cell0.add(new Paragraph("YES I START UP – Formazione per l'Avvio d'Impresa").addStyle(bold));
                    cell0.add(new Paragraph("Edizione 2021/2022").addStyle(bold));
                    cell0.add(new Paragraph("Misura 7.1 (PON IOG 2014-2020)").addStyle(bold));
                    cell0.add(new Paragraph("CUP E51G21000000006").addStyle(bold));

                    cell0.setTextAlignment(TextAlignment.CENTER);
                    table.addCell(cell0);

                    Cell cell = new Cell(1, 8);
                    cell.add(new Paragraph(" ").addStyle(normal));
                    cell.setTextAlignment(TextAlignment.CENTER);
                    cell.setBorder(Border.NO_BORDER);
                    table.addCell(cell);
                    cell = new Cell(1, 8);
                    cell.add(new Paragraph(" ").addStyle(normal));
                    cell.setTextAlignment(TextAlignment.CENTER);
                    cell.setBorder(Border.NO_BORDER);
                    table.addCell(cell);
                    cell = new Cell();
                    cell.add(new Paragraph("SOGGETTO ESECUTORE").addStyle(bold));
                    table.addCell(cell);
                    cell = new Cell();
                    cell.add(new Paragraph(datisa[0]).addStyle(normal));
                    cell.setBackgroundColor(lightgrey);
                    table.addCell(cell);
                    cell = new Cell();
                    cell.add(new Paragraph("CIP").addStyle(bold));
                    table.addCell(cell);
                    cell = new Cell();
                    cell.add(new Paragraph(datisa[1]).addStyle(normal));
                    cell.setBackgroundColor(lightgrey);
                    table.addCell(cell);

                    if (!registro.isEmpty()) {

                        Registro_completo primo = registro.get(0);
                        cell = new Cell();
                        cell.add(new Paragraph("DATA").addStyle(bold));
                        table.addCell(cell);
                        cell = new Cell();
                        cell.add(new Paragraph(primo.getData().toString(patternITA)).addStyle(normal));
                        cell.setBackgroundColor(lightgrey);
                        table.addCell(cell);
                        cell = new Cell();
                        cell.add(new Paragraph("ID RIUNIONE").addStyle(bold));
                        table.addCell(cell);
                        cell = new Cell();
                        cell.add(new Paragraph(primo.getIdriunione()).addStyle(normal));
                        cell.setBackgroundColor(lightgrey);
                        table.addCell(cell);
                        cell = new Cell();
                        cell.add(new Paragraph("N. PARTECIPANTI").addStyle(bold));
                        table.addCell(cell);
                        cell = new Cell();
                        cell.add(new Paragraph("ORA INIZIO").addStyle(bold));
                        table.addCell(cell);
                        cell = new Cell();
                        cell.add(new Paragraph("ORA FINE").addStyle(bold));
                        table.addCell(cell);
                        cell = new Cell();
                        cell.add(new Paragraph("DURATA").addStyle(bold));
                        table.addCell(cell);
                        cell = new Cell(1, 2);
                        cell.add(new Paragraph("N.UD - FASE B").addStyle(bold));
                        table.addCell(cell);
                        cell = new Cell(1, 2);
                        cell.add(new Paragraph("NUMERO GRUPPO FASE B").addStyle(bold));
                        table.addCell(cell);

                        cell = new Cell();
                        cell.add(new Paragraph(String.valueOf(primo.getNumpartecipanti())).addStyle(normal));
                        cell.setBackgroundColor(lightgrey);
                        cell.setTextAlignment(TextAlignment.CENTER);
                        table.addCell(cell);
                        cell = new Cell();
                        cell.add(new Paragraph(primo.getOrainizio()).addStyle(normal));
                        cell.setBackgroundColor(lightgrey);
                        cell.setTextAlignment(TextAlignment.CENTER);
                        table.addCell(cell);
                        cell = new Cell();
                        cell.add(new Paragraph(primo.getOrafine()).addStyle(normal));
                        cell.setBackgroundColor(lightgrey);
                        cell.setTextAlignment(TextAlignment.CENTER);
                        table.addCell(cell);
                        cell = new Cell();
                        cell.add(new Paragraph(calcoladurata(primo.getDurata())).addStyle(normal));
                        cell.setBackgroundColor(lightgrey);
                        cell.setTextAlignment(TextAlignment.CENTER);
                        table.addCell(cell);
                        cell = new Cell(1, 2);
                        cell.add(new Paragraph(primo.getNud()).addStyle(normal));
                        cell.setBackgroundColor(lightgrey);
                        cell.setTextAlignment(TextAlignment.CENTER);
                        table.addCell(cell);
                        cell = new Cell(1, 2);
                        cell.add(new Paragraph(String.valueOf(primo.getGruppofaseb())).addStyle(normal));
                        cell.setBackgroundColor(lightgrey);
                        cell.setTextAlignment(TextAlignment.CENTER);
                        cell.setTextAlignment(TextAlignment.CENTER);
                        table.addCell(cell);
                        cell = new Cell(1, 8);
                        cell.add(new Paragraph(" ").addStyle(normal));
                        cell.setTextAlignment(TextAlignment.CENTER);
                        cell.setBorder(Border.NO_BORDER);
                        table.addCell(cell);
                        Cell cel2 = new Cell();
                        cel2.add(new Paragraph("COGNOME").addStyle(bold));
                        table.addCell(cel2);
                        cel2 = new Cell();
                        cel2.add(new Paragraph("NOME").addStyle(bold));
                        table.addCell(cel2);
                        cel2 = new Cell();
                        cel2.add(new Paragraph("RUOLO").addStyle(bold));
                        table.addCell(cel2);
                        cel2 = new Cell();
                        cel2.add(new Paragraph("EMAIL").addStyle(bold));
                        table.addCell(cel2);
                        cel2 = new Cell();
                        cel2.add(new Paragraph("ORA DI ENTRATA (LOGIN)").addStyle(bold));
                        table.addCell(cel2);
                        cel2 = new Cell();
                        cel2.add(new Paragraph("ORA DI USCITA (LOGOUT)").addStyle(bold));
                        table.addCell(cel2);
                        cel2 = new Cell();
                        cel2.add(new Paragraph("TOTALE ORE").addStyle(bold));
                        table.addCell(cel2);
                        cel2 = new Cell();
                        cel2.add(new Paragraph("TOTALE ORE RENDICONTABILI").addStyle(bold));
                        table.addCell(cel2);
                        registro.forEach(r1 -> {
                            Cell cel3 = new Cell();
                            cel3.add(new Paragraph(r1.getCognome()).addStyle(normal));
                            table.addCell(cel3);
                            cel3 = new Cell();
                            cel3.add(new Paragraph(r1.getNome()).addStyle(normal));
                            table.addCell(cel3);
                            cel3 = new Cell();
                            cel3.add(new Paragraph(r1.getRuolo()).addStyle(normal));
                            table.addCell(cel3);
                            cel3 = new Cell();
                            cel3.add(new Paragraph(r1.getEmail()).addStyle(normal));
                            table.addCell(cel3);
                            cel3 = new Cell();
                            cel3.add(new Paragraph(r1.getOrelogin()).addStyle(normal));
                            table.addCell(cel3);
                            cel3 = new Cell();
                            cel3.add(new Paragraph(r1.getOrelogout()).addStyle(normal));
                            table.addCell(cel3);
                            cel3 = new Cell();
                            cel3.add(new Paragraph(calcoladurata(r1.getTotaleore())).addStyle(normal));
                            table.addCell(cel3);
                            cel3 = new Cell();
                            cel3.add(new Paragraph(calcoladurata(r1.getTotaleorerendicontabili())).addStyle(normal));
                            table.addCell(cel3);
                        });
                    } else {
                        cell = new Cell();
                        cell.add(new Paragraph("DATA").addStyle(bold));
                        table.addCell(cell);
                        cell = new Cell();
                        cell.add(new Paragraph(formatStringtoStringDateSQL(day)).addStyle(normal));
                        cell.setBackgroundColor(lightgrey);
                        table.addCell(cell);
                        cell = new Cell(1, 2);
                        cell.add(new Paragraph("NESSUNA LEZIONE TROVATA").addStyle(bold));
                        table.addCell(cell);
                    }
                } catch (Exception ex) {
                    insertTR("E", "SERVICE", estraiEccezione(ex));
                }
                doc.add(table);
                if (indice1.get() < fb.size()) {
                    doc.add(new AreaBreak(AreaBreakType.NEXT_PAGE));
                }
                indice1.addAndGet(1);

            });

            db1.closeDB();

            if (indice.get() > 1) {

                doc.close();
                pdfDoc.close();
                pw0.close();

                String qrcontent = "ID " + idpr + " REGISTRO COMPLESSIVO- AGGIORNATO IL " + now;
                File out1 = new File(StringUtils.replace(out0.getPath(), ".pdf", "_qr.pdf"));
                try (PdfReader p2 = new PdfReader(out0); PdfWriter p2w = new PdfWriter(out1); PdfDocument pdfDoc1 = new PdfDocument(p2, p2w)) {
                    BarcodeQRCode barcode = new BarcodeQRCode(qrcontent);
                    String add = "Questo registro è stato generato automaticamente dalla piattaforma raggiungibile al link: "
                            + linkpiattaforma;
                    printbarcode(barcode, pdfDoc1, true, add);
                }

                out0.deleteOnExit();

                File pdf_final = new File(path_destinazione + File.separator + "Registro Complessivo_" + now1 + ".pdf");
                File sanitizeFile = sanitizeFile(pdf_final);
                File out1S = sanitizeFile(out1);
                FileUtils.copyFile(out1S, sanitizeFile);
                if (checkPDF(sanitizeFile)) {
                    out1S.deleteOnExit();
                    if (save) {
                        Database db3 = new Database(false);
                        try {
                            String jpql = "SELECT d FROM DocumentiPrg d WHERE d.progetto.id = :idprogetto AND d.tipo.id = 33";
                            TypedQuery<DocumentiPrg> query = db3.getEm()
                                    .createQuery(jpql, DocumentiPrg.class)
                                    .setParameter("idprogetto", idpr);

                            List<DocumentiPrg> results = query.getResultList();

                            db3.getEm().getTransaction().begin();

                            if (!results.isEmpty()) {
                                // Documento esistente → aggiorno path
                                DocumentiPrg doc1 = results.get(0);
                                doc1.setPath(pdf_final.getPath());
                                db3.getEm().merge(doc1);
                            } else {
                                // Nessun documento → inserisco nuovo
                                DocumentiPrg newDoc = new DocumentiPrg();
                                newDoc.setPath(pdf_final.getPath());

                                ProgettiFormativi progettoEntity = db3.getEm().find(ProgettiFormativi.class, idpr);
                                newDoc.setProgetto(progettoEntity);

                                TipoDoc tipoEntity = db3.getEm().find(TipoDoc.class, 33);
                                newDoc.setTipo(tipoEntity);
                                newDoc.setDeleted(0);
                                db3.getEm().persist(newDoc);
                            }

                            db3.getEm().getTransaction().commit();

                        } catch (Exception ex) {
                            if (db3.getEm().getTransaction().isActive()) {
                                db3.getEm().getTransaction().rollback();
                            }
                            insertTR("E", "SERVICE", estraiEccezione(ex));
                        } finally {
                            db3.closeDB();
                        }
                    }

                    return pdf_final;
                }
            }

        } catch (IOException ex) {
            insertTR("E", "SERVICE", estraiEccezione(ex));
        }

        return null;
    }

    public File registro_complessivo(int idpr, String host, boolean save) {
        List<File> temp = new ArrayList<>();
        Database db = new Database(false);
        try {
            String sql = "SELECT * FROM documenti_progetti WHERE idprogetto = " + idpr
                    + " AND tipo IN (29,32) AND deleted=0 ORDER BY tipo";

            Query query = db.getEm().createNativeQuery(sql, DocumentiPrg.class);
            List<DocumentiPrg> results = query.getResultList();

            for (DocumentiPrg rs : results) {
                String path = rs.getPath();

                File t1 = new File(path.replace("..", "").replace("\\", "").replace("/", ""));
                File sanitizeFile = sanitizeFile(t1);
                if (checkPDF(sanitizeFile)) {
                    temp.add(t1);
                }
            }

            try (PdfDocument pdf = new PdfDocument(
                    new PdfWriter("C:\\mnt\\mcn\\yisu_neet\\SoggettiAttuatori\\36\\Progetti\\82\\testing.pdf"))) {
                PdfMerger merger = new PdfMerger(pdf);
                temp.forEach(f1 -> {
                    try {
                        try (PdfDocument firstSourcePdf = new PdfDocument(new PdfReader(f1.getPath()))) {
                            merger.merge(firstSourcePdf, 1, firstSourcePdf.getNumberOfPages());
                        }
                    } catch (Exception ex) {
                        insertTR("E", "SERVICE", estraiEccezione(ex));
                    }
                });
            }

        } catch (Exception ex) {
            insertTR("E", "SERVICE", estraiEccezione(ex));
        }
        db.closeDB();
        return null;
    }

    public String getHost() {
        return host;
    }

    public void setHost(String host) {
        this.host = host;
    }

}
