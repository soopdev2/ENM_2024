/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rc.so.util;

import rc.so.entity.Registro_completo;
import rc.so.domain.Docenti;
import rc.so.domain.ProgettiFormativi;
import rc.so.domain.SoggettiAttuatori;
import rc.so.domain.User;
import rc.so.entity.FadCalendar;
import static rc.so.util.Utility.estraiEccezione;
import static rc.so.util.Utility.pregresso;
import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;
import jakarta.persistence.TypedQuery;
import rc.so.db.Database;
import rc.so.db.Entity;
import static org.apache.commons.io.FilenameUtils.separatorsToSystem;

/**
 *
 * @author smo
 */
public class Action {

    public static void insertTR(String type, String user, String descr) {
        try {
            Database db = new Database(false);
            db.insertTR(type, user, descr);
            db.closeDB();
        } catch (Exception e) {
        }
    }

    public static File createFile_R(String path) {
        try {
            File out = new File(separatorsToSystem(path));
            if (out.exists() && out.canRead()) {
                return out;
            }
        } catch (Exception e) {
        }
        return null;
    }

    public static boolean isVisibile(String gruppo, String page) {//(tipo, pagina)

        Database db = new Database(false);
        if (db.getC() == null) {
            return false;
        }

        String gruppoFix = sanitizePath(gruppo);
        String pageFix = sanitizePath(page);

        boolean c = db.isVisible(gruppoFix, pageFix);
        db.closeDB();
        return c;

//        Entity e = new Entity();
//        boolean out = e.isVisible(gruppo, page);
//        e.close();
//        return out;
    }

    private static String sanitizePath(String path) {
        return path.replaceAll("[^a-zA-Z0-9-_./]", "");
    }

    public static boolean isModifiable(String modificabile, String stato) {//usato anche per la visualizzazione dei modelli
        if (modificabile != null) {
            StringTokenizer st = new StringTokenizer(modificabile, "-");
            while (st.hasMoreTokens()) {
                if (stato.equals(st.nextToken())) {
                    return true;
                }
            }
        }
        return false;
    }

    public static int countPregresso() {
        if (!pregresso) {
            return 0;
        }
        Database db = new Database(false);
        if (db.getC() == null) {
            return 0;
        }
        int c = db.countPregresso();
        db.closeDB();
        return c;
    }

    public static List<FadCalendar> calendarioFAD(String id) {
        List<FadCalendar> out = new ArrayList<>();
        Database db = new Database(false);
        if (db.getC() == null) {
            return out;
        }
        out = db.calendarioFAD(id);
        db.closeDB();
        return out;
    }

    public static String linkFAD() {
        Database db = new Database(false);
        if (db.getC() == null) {
            return "https://accreditamento.diventaimprenditore.eu/fad_neet/";
        }
        String out = db.getPathtemp("linkfad");
        db.closeDB();
        return out;
    }

    public static String[] contatoriHomeSA(User us) {
        String[] out = {
            "0", "0", "0",
            "0"
        };
        return out;
    }

    public static String[] contatoriHome() {

        String[] out = {
            "0", "0", "0",
            "0", "0", "0",
            "0", "0", "0",
            "0", "0", "0",
            "0", "0", "0",
            "0", "0", "0",
            "0", "0", "0"
        };

        
        return out;

    }

    public static String[] dati_modello5_neet(String idneet, String idsa, String pf) {
        Database db = new Database(false);
        String[] r = db.dati_modello5_neet(idneet, idsa, pf);
        db.closeDB();
        return r;
    }

    public static boolean rendicontazione_abilitata(String username) {
        Database db = new Database(false);
        String listuser = db.getPathtemp("user_rend");
        db.closeDB();
        return listuser.toLowerCase().contains(listuser.toLowerCase());
    }

    public static List<Registro_completo> registro_modello6(String idpr) {
        Database db = new Database(false);

        String idprfix = sanitizePath(idpr);

        List<Registro_completo> rc = db.registro_modello6(idprfix);
        db.closeDB();
        return rc;
    }

    public static List<String[]> ore_rendicontabili() {
        List<String[]> out = new ArrayList<>();
        out.add(new String[]{"0", "0h"});
        out.add(new String[]{"1800000", "0h 30m"});
        out.add(new String[]{"3600000", "1h"});
        out.add(new String[]{"5400000", "1h 30m"});
        out.add(new String[]{"7200000", "2h"});
        out.add(new String[]{"9000000", "2h 30m"});
        out.add(new String[]{"10800000", "3h"});
        out.add(new String[]{"12600000", "3h 30m"});
        out.add(new String[]{"14400000", "4h"});
        out.add(new String[]{"16200000", "4h 30m"});
        out.add(new String[]{"18000000", "5h"});
        return out;
    }

}
