/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rc.so.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

/**
 *
 * @author smo
 */
@Entity
@Table(name = "allievi")
@NamedQueries(value = {
    @NamedQuery(name = "a.byCF", query = "SELECT a FROM Allievi a WHERE a.codicefiscale=:codicefiscale AND a.statopartecipazione.id='01'"),
    @NamedQuery(name = "a.bySoggettoAttuatore", query = "SELECT a FROM Allievi a WHERE a.soggetto=:soggetto"),
    @NamedQuery(name = "a.bySoggettoAttuatoreNoProgettoAttivi", query = "SELECT a FROM Allievi a WHERE a.soggetto=:soggetto and a.progetto=null AND a.statopartecipazione.id='01' AND a.stato='A'"),
    @NamedQuery(name = "a.byProgetto", query = "SELECT a FROM Allievi a WHERE a.progetto=:progetto AND a.statopartecipazione.id IN ('13','14','15','18','19')"),
    @NamedQuery(name = "a.byProgettoAll", query = "SELECT a FROM Allievi a WHERE a.progetto=:progetto"),
    @NamedQuery(name = "a.byEmail", query = "SELECT a FROM Allievi a WHERE a.email=:email AND a.statopartecipazione.id='01'"),
    @NamedQuery(name = "allievi.daassegnare", query = "SELECT a FROM Allievi a WHERE a.statopartecipazione.id='10'"),
    @NamedQuery(name = "allievi.assegnatisoggetto", query = "SELECT a FROM Allievi a WHERE a.statopartecipazione.id IN ('12','13') AND a.soggetto=:soggetto and a.progetto=null"),
    @NamedQuery(name = "allievi.modello1", query = "SELECT a FROM Allievi a WHERE a.statopartecipazione.id='13' AND a.soggetto=:soggetto and a.progetto=null"),
    @NamedQuery(name = "allievi.attivi", query = "SELECT a FROM Allievi a WHERE a.statopartecipazione.id='13' AND a.progetto=:progetto"),
})
@JsonIgnoreProperties(value = {"documenti"})
public class Allievi implements Serializable {

    @Id
    @Column(name = "idallievi")
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long id;
    @Column(name = "nome")
    private String nome;
    @Column(name = "cognome")
    private String cognome;
    @Column(name = "codicefiscale")
    private String codicefiscale;
    @Temporal(TemporalType.DATE)
    @Column(name = "datanascita")
    private Date datanascita;
    @Column(name = "indirizzodomicilio")
    private String indirizzodomicilio;
    @Column(name = "indirizzoresidenza")
    private String indirizzoresidenza;
    @Column(name = "civicodomicilio")
    private String civicodomicilio;
    @Column(name = "civicoresidenza")
    private String civicoresidenza;
    @Column(name = "capdomicilio")
    private String capdomicilio;
    @Column(name = "capresidenza")
    private String capresidenza;
    @Column(name = "protocollo")
    private String protocollo;
    @Column(name = "esito")
    private String esito = "-";
    @Column(name = "esclusione_prg")
    private String esclusione_prg;
    @Temporal(TemporalType.DATE)
    @Column(name = "iscrizionegg")
    private Date iscrizionegg;
    @Column(name = "datacpi")
    @Temporal(TemporalType.DATE)
    private Date datacpi;
    @Column(name = "neet")
    private String neet;
    @Column(name = "docid")
    private String docid;
    @Column(name = "scadenzadocid")
    @Temporal(TemporalType.DATE)
    private Date scadenzadocid;
    @Column(name = "stato")
    private String stato;
    @Column(name = "idea_impresa")
    private String idea_impresa;
    @Column(name = "email")
    private String email;
    @Column(name = "sesso")
    private String sesso;
    @Column(name = "telefono")
    private String telefono;
    @Column(name = "importo")
    private double importo;
    @Temporal(TemporalType.DATE)
    @Column(name = "data_up")
    private Date data_up;
    @ManyToOne
    @JoinColumn(name = "cittadinanza")
    private Nazioni_rc cittadinanza;
    @ManyToOne
    @JoinColumn(name = "comune_nascita")
    private Comuni comune_nascita;
    @ManyToOne
    @JoinColumn(name = "comune_residenza")
    private Comuni comune_residenza;
    @ManyToOne
    @JoinColumn(name = "comune_domicilio")
    private Comuni comune_domicilio;
    @ManyToOne
    @JoinColumn(name = "titolo_studio")
    private TitoliStudio titoloStudio;
    @ManyToOne
    @JoinColumn(name = "idprogetti_formativi")
    ProgettiFormativi progetto;
    @ManyToOne
    @JoinColumn(name = "idsoggetto_attuatore")
    SoggettiAttuatori soggetto;
    @ManyToOne
    @JoinColumn(name = "cpi")
    CPI cpi;

    @Column(name = "stato_nascita")
    private String stato_nascita;
    @Column(name = "privacy2")
    private String privacy2;
    @Column(name = "privacy3")
    private String privacy3;

    @Column(name = "data_anpal")
    private String data_anpal;

    @ManyToOne
    @JoinColumn(name = "idcondizione_mercato")
    Condizione_Mercato condizione_mercato;
    @ManyToOne
    @JoinColumn(name = "id_selfiemployement")
    Selfiemployment_Prestiti selfiemployement;
    @ManyToOne
    @JoinColumn(name = "id_statopartecipazione")
    StatoPartecipazione statopartecipazione;
    
    
    @ManyToOne
    @JoinColumn(name = "idcondizione_lavorativa")
    Condizione_Lavorativa condizione_lavorativa;

    @ManyToOne
    @JoinColumn(name = "motivazione")
    Motivazione motivazione;

    @ManyToOne
    @JoinColumn(name = "idcanale")
    Canale canale;

    @OneToMany(mappedBy = "allievo", fetch = FetchType.LAZY)
    List<Documenti_Allievi> documenti;

    @Transient
    private boolean pregresso;
    @Transient
    private double ore_fa = 0.0;
    @Transient
    private double ore_fb = 0.0;
    @Transient
    private String orerendicontabili  = "";

    //Gruppo modello 4
    @Column(name = "gruppo_faseB")
    private int gruppo_faseB;

     // 0 - DA SALVARE (NO) - 1 SI
    @Column(name = "mappatura")
    private int mappatura;
    
    @Column(name = "mappatura_note")
    private String mappatura_note;
    
    @Column(name = "surveyin", columnDefinition = "TINYINT", length = 1)
    private boolean surveyin;
    
    @Column(name = "surveyout", columnDefinition = "TINYINT", length = 1)
    private boolean surveyout;
    
    
    @Column(name = "tos_tipofinanziamento") 
    private String tos_tipofinanziamento; //GOL - PATTO PER IL LAVORO
        
    @Column(name = "tos_dirittoindennita") 
    private String tos_dirittoindennita; 

    @ManyToOne
    @JoinColumn(name = "tos_gruppovulnerabile")
    GruppoVulnerabile tos_gruppovulnerabile;
    
    @Column(name = "tos_request", columnDefinition = "LONGTEXT") 
    private String tos_request;
    
    
    
    //MODELLO 0
    @Temporal(TemporalType.DATE)
    @Column(name = "tos_m0_datacolloquio")
    private Date tos_m0_datacolloquio;
    
     @Column(name = "tos_m0_siglaoperatore") 
    private String tos_m0_siglaoperatore;
     
    @Column(name = "tos_m0_modalitacolloquio") 
    private int tos_m0_modalitacolloquio;
    
    @Column(name = "tos_m0_gradoconoscenza") 
    private int tos_m0_gradoconoscenza;
    
    @ManyToOne
    @JoinColumn(name = "tos_m0_canaleconoscenza")
    private Canale tos_m0_canaleconoscenza;
    
    @ManyToOne
    @JoinColumn(name = "tos_m0_motivazione")
    private Motivazione tos_m0_motivazione;
    
    @Column(name = "tos_m0_utilita") 
    private int tos_m0_utilita;
    
    @Column(name = "tos_m0_aspettative") 
    private int tos_m0_aspettative;
    
    @ManyToOne
    @JoinColumn(name = "tos_m0_maturazione") 
    private MaturazioneIdea tos_m0_maturazione;
    
    @Column(name = "tos_m0_volonta") 
    private int tos_m0_volonta;
    
    @ManyToOne
    @JoinColumn(name = "tos_m0_noperche") 
    private MotivazioneNO tos_m0_noperche;
    
    @Column(name = "tos_m0_noperchealtro") 
    private String tos_m0_noperchealtro;
    
    @Column(name = "tos_m0_consapevole") 
    private int tos_m0_consapevole;
    
    
    
    
    
    @Column(name = "tos_mailoriginale") 
    private String tos_mailoriginale;
    
    //  NEW
    @Column(name = "tos_operatore") 
    private String tos_operatore;

    @Column(name = "tos_noteenm", columnDefinition = "LONGTEXT") 
    private String tos_noteenm;
    
    
    public Allievi() {
        this.pregresso = false;
    }

    public String getTos_noteenm() {
        return tos_noteenm;
    }

    public void setTos_noteenm(String tos_noteenm) {
        this.tos_noteenm = tos_noteenm;
    }
    
    public int getTos_m0_consapevole() {
        return tos_m0_consapevole;
    }

    public void setTos_m0_consapevole(int tos_m0_consapevole) {
        this.tos_m0_consapevole = tos_m0_consapevole;
    }

    public MaturazioneIdea getTos_m0_maturazione() {
        return tos_m0_maturazione;
    }

    public void setTos_m0_maturazione(MaturazioneIdea tos_m0_maturazione) {
        this.tos_m0_maturazione = tos_m0_maturazione;
    }

    public String getTos_operatore() {
        return tos_operatore;
    }

    public void setTos_operatore(String tos_operatore) {
        this.tos_operatore = tos_operatore;
    }

    public String getTos_request() {
        return tos_request;
    }

    public void setTos_request(String tos_request) {
        this.tos_request = tos_request;
    }

    public String getTos_tipofinanziamento() {
        return tos_tipofinanziamento;
    }

    public void setTos_tipofinanziamento(String tos_tipofinanziamento) {
        this.tos_tipofinanziamento = tos_tipofinanziamento;
    }

    public String getTos_dirittoindennita() {
        return tos_dirittoindennita;
    }

    public void setTos_dirittoindennita(String tos_dirittoindennita) {
        this.tos_dirittoindennita = tos_dirittoindennita;
    }

    public GruppoVulnerabile getTos_gruppovulnerabile() {
        return tos_gruppovulnerabile;
    }

    public void setTos_gruppovulnerabile(GruppoVulnerabile tos_gruppovulnerabile) {
        this.tos_gruppovulnerabile = tos_gruppovulnerabile;
    }

    public Date getTos_m0_datacolloquio() {
        return tos_m0_datacolloquio;
    }

    public void setTos_m0_datacolloquio(Date tos_m0_datacolloquio) {
        this.tos_m0_datacolloquio = tos_m0_datacolloquio;
    }

    public String getTos_m0_siglaoperatore() {
        return tos_m0_siglaoperatore;
    }

    public void setTos_m0_siglaoperatore(String tos_m0_siglaoperatore) {
        this.tos_m0_siglaoperatore = tos_m0_siglaoperatore;
    }

    public int getTos_m0_modalitacolloquio() {
        return tos_m0_modalitacolloquio;
    }

    public void setTos_m0_modalitacolloquio(int tos_m0_modalitacolloquio) {
        this.tos_m0_modalitacolloquio = tos_m0_modalitacolloquio;
    }

    public int getTos_m0_gradoconoscenza() {
        return tos_m0_gradoconoscenza;
    }

    public void setTos_m0_gradoconoscenza(int tos_m0_gradoconoscenza) {
        this.tos_m0_gradoconoscenza = tos_m0_gradoconoscenza;
    }

    public Canale getTos_m0_canaleconoscenza() {
        return tos_m0_canaleconoscenza;
    }

    public void setTos_m0_canaleconoscenza(Canale tos_m0_canaleconoscenza) {
        this.tos_m0_canaleconoscenza = tos_m0_canaleconoscenza;
    }

    public Motivazione getTos_m0_motivazione() {
        return tos_m0_motivazione;
    }

    public void setTos_m0_motivazione(Motivazione tos_m0_motivazione) {
        this.tos_m0_motivazione = tos_m0_motivazione;
    }

    public int getTos_m0_utilita() {
        return tos_m0_utilita;
    }

    public void setTos_m0_utilita(int tos_m0_utilita) {
        this.tos_m0_utilita = tos_m0_utilita;
    }

    public int getTos_m0_aspettative() {
        return tos_m0_aspettative;
    }

    public void setTos_m0_aspettative(int tos_m0_aspettative) {
        this.tos_m0_aspettative = tos_m0_aspettative;
    }

    public int getTos_m0_volonta() {
        return tos_m0_volonta;
    }

    public void setTos_m0_volonta(int tos_m0_volonta) {
        this.tos_m0_volonta = tos_m0_volonta;
    }

    public MotivazioneNO getTos_m0_noperche() {
        return tos_m0_noperche;
    }

    public void setTos_m0_noperche(MotivazioneNO tos_m0_noperche) {
        this.tos_m0_noperche = tos_m0_noperche;
    }

    public String getTos_m0_noperchealtro() {
        return tos_m0_noperchealtro;
    }

    public void setTos_m0_noperchealtro(String tos_m0_noperchealtro) {
        this.tos_m0_noperchealtro = tos_m0_noperchealtro;
    }

    public String getTos_mailoriginale() {
        return tos_mailoriginale;
    }

    public void setTos_mailoriginale(String tos_mailoriginale) {
        this.tos_mailoriginale = tos_mailoriginale;
    }

    public boolean isSurveyin() {
        return surveyin;
    }

    public void setSurveyin(boolean surveyin) {
        this.surveyin = surveyin;
    }

    public boolean isSurveyout() {
        return surveyout;
    }

    public void setSurveyout(boolean surveyout) {
        this.surveyout = surveyout;
    }
    
    public String getMappatura_note() {
        return mappatura_note;
    }

    public void setMappatura_note(String mappatura_note) {
        this.mappatura_note = mappatura_note;
    }

    public String getOrerendicontabili() {
        return orerendicontabili;
    }

    public void setOrerendicontabili(String orerendicontabili) {
        this.orerendicontabili = orerendicontabili;
    }

    public int getMappatura() {
        return mappatura;
    }

    public void setMappatura(int mappatura) {
        this.mappatura = mappatura;
    }

    public String getData_anpal() {
        return data_anpal;
    }

    public void setData_anpal(String data_anpal) {
        this.data_anpal = data_anpal;
    }

    public Allievi(boolean preg) {
        this.pregresso = preg;
        if (preg) {
            this.id = 0L;
            this.nome = "";
            this.cognome = "";
            this.codicefiscale = "";
            this.datanascita = new Date();
            this.indirizzodomicilio = "";
            this.indirizzoresidenza = "";
            this.civicodomicilio = "";
            this.civicoresidenza = "";
            this.capdomicilio = "";
            this.capresidenza = "";
            this.protocollo = "";
            this.iscrizionegg = new Date();
            this.datacpi = new Date();
            this.motivazione = new Motivazione();
            this.neet = "";
            this.docid = "";
            this.scadenzadocid = new Date();
            this.stato = "";
            this.idea_impresa = "";
            this.email = "";
            this.sesso = "";
            this.telefono = "";
            this.data_up = new Date();
            this.cittadinanza = new Nazioni_rc();
            this.comune_nascita = new Comuni();
            this.comune_residenza = new Comuni();
            this.comune_domicilio = new Comuni();
            this.titoloStudio = new TitoliStudio();
            this.progetto = new ProgettiFormativi();
            this.soggetto = new SoggettiAttuatori();
            this.cpi = new CPI();
            this.condizione_mercato = new Condizione_Mercato();
            this.selfiemployement = new Selfiemployment_Prestiti();
            this.statopartecipazione = new StatoPartecipazione();
            this.condizione_lavorativa = new Condizione_Lavorativa();
            this.canale = new Canale();
            this.documenti = new ArrayList<>();
        }
    }

    public Allievi(Long id, String nome, String cognome, int gruppo_faseB) {
        this.id = id;
        this.nome = nome;
        this.cognome = cognome;
        this.gruppo_faseB = gruppo_faseB;
        this.codicefiscale = "";
    }

    public Allievi(Long id, String nome, String cognome) {
        this.id = id;
        this.nome = nome;
        this.cognome = cognome;
        this.codicefiscale = "";
    }

    public String getEsclusione_prg() {
        return esclusione_prg;
    }

    public void setEsclusione_prg(String esclusione_prg) {
        this.esclusione_prg = esclusione_prg;
    }

    public int getGruppo_faseB() {
        return gruppo_faseB;
    }

    public void setGruppo_faseB(int gruppo_faseB) {
        this.gruppo_faseB = gruppo_faseB;
    }

    public Canale getCanale() {
        return canale;
    }

    public void setCanale(Canale canale) {
        this.canale = canale;
    }

    public boolean isPregresso() {
        return pregresso;
    }

    public void setPregresso(boolean pregresso) {
        this.pregresso = pregresso;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNome() {
        return nome.toUpperCase();
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCognome() {
        return cognome.toUpperCase();
    }

    public void setCognome(String cognome) {
        this.cognome = cognome;
    }

    public String getCodicefiscale() {
        return codicefiscale.toUpperCase();
    }

    public void setCodicefiscale(String codicefiscale) {
        this.codicefiscale = codicefiscale;
    }

    public Date getDatanascita() {
        return datanascita;
    }

    public void setDatanascita(Date datanascita) {
        this.datanascita = datanascita;
    }

    public String getSesso() {
        return sesso;
    }

    public void setSesso(String sesso) {
        this.sesso = sesso;
    }

    public String getIndirizzodomicilio() {
        return indirizzodomicilio;
    }

    public void setIndirizzodomicilio(String indirizzodomicilio) {
        this.indirizzodomicilio = indirizzodomicilio;
    }

    public String getIndirizzoresidenza() {
        return indirizzoresidenza;
    }

    public void setIndirizzoresidenza(String indirizzoresidenza) {
        this.indirizzoresidenza = indirizzoresidenza;
    }

    public String getCivicodomicilio() {
        return civicodomicilio;
    }

    public void setCivicodomicilio(String civicodomicilio) {
        this.civicodomicilio = civicodomicilio;
    }

    public String getCivicoresidenza() {
        return civicoresidenza;
    }

    public void setCivicoresidenza(String civicoresidenza) {
        this.civicoresidenza = civicoresidenza;
    }

    public String getCapdomicilio() {
        return capdomicilio;
    }

    public void setCapdomicilio(String capdomicilio) {
        this.capdomicilio = capdomicilio;
    }

    public String getCapresidenza() {
        return capresidenza;
    }

    public void setCapresidenza(String capresidenza) {
        this.capresidenza = capresidenza;
    }

    public String getProtocollo() {
        return protocollo;
    }

    public void setProtocollo(String protocollo) {
        this.protocollo = protocollo;
    }

    public String getEsito() {
        return esito;
    }

    public void setEsito(String esito) {
        this.esito = esito;
    }

    public Date getIscrizionegg() {
        return iscrizionegg;
    }

    public void setIscrizionegg(Date iscrizionegg) {
        this.iscrizionegg = iscrizionegg;
    }

    public Comuni getComune_nascita() {
        return comune_nascita;
    }

    public void setComune_nascita(Comuni comune_nascita) {
        this.comune_nascita = comune_nascita;
    }

    public Comuni getComune_residenza() {
        return comune_residenza;
    }

    public void setComune_residenza(Comuni comune_residenza) {
        this.comune_residenza = comune_residenza;
    }

    public Comuni getComune_domicilio() {
        return comune_domicilio;
    }

    public void setComune_domicilio(Comuni comune_domicilio) {
        this.comune_domicilio = comune_domicilio;
    }

    public SoggettiAttuatori getSoggetto() {
        return soggetto;
    }

    public void setSoggetto(SoggettiAttuatori soggetto) {
        this.soggetto = soggetto;
    }

    public TitoliStudio getTitoloStudio() {
        return titoloStudio;
    }

    public void setTitoloStudio(TitoliStudio titoloStudio) {
        this.titoloStudio = titoloStudio;
    }

    public ProgettiFormativi getProgetto() {
        return progetto;
    }

    public void setProgetto(ProgettiFormativi progetto) {
        this.progetto = progetto;
    }

    public String getDocid() {
        return docid;
    }

    public void setDocid(String docid) {
        this.docid = docid;
    }

    public Date getScadenzadocid() {
        return scadenzadocid;
    }

    public void setScadenzadocid(Date scadenzadocid) {
        this.scadenzadocid = scadenzadocid;
    }

    public String getStato() {
        return stato;
    }

    public void setStato(String stato) {
        this.stato = stato;
    }

    public CPI getCpi() {
        return cpi;
    }

    public void setCpi(CPI cpi) {
        this.cpi = cpi;
    }

    public Date getDatacpi() {
        return datacpi;
    }

    public void setDatacpi(Date datacpi) {
        this.datacpi = datacpi;
    }

    public Motivazione getMotivazione() {
        return motivazione;
    }

    public void setMotivazione(Motivazione motivazione) {
        this.motivazione = motivazione;
    }

    public String getNeet() {
        return neet;
    }

    public void setNeet(String neet) {
        this.neet = neet;
    }

    public List<Documenti_Allievi> getDocumenti() {
        List<Documenti_Allievi> docs = new ArrayList<>();//per fixare il bug dello stream  per le lazy list di EclipseLink
        docs.addAll(this.documenti);
        return docs;
    }

    public void setDocumenti(List<Documenti_Allievi> documenti) {
        this.documenti = documenti;
    }

    public Nazioni_rc getCittadinanza() {
        return cittadinanza;
    }

    public void setCittadinanza(Nazioni_rc cittadinanza) {
        this.cittadinanza = cittadinanza;
    }

    public Condizione_Mercato getCondizione_mercato() {
        return condizione_mercato;
    }

    public void setCondizione_mercato(Condizione_Mercato condizione_mercato) {
        this.condizione_mercato = condizione_mercato;
    }

    public Selfiemployment_Prestiti getSelfiemployement() {
        return selfiemployement;
    }

    public void setSelfiemployement(Selfiemployment_Prestiti selfiemployement) {
        this.selfiemployement = selfiemployement;
    }

    public StatoPartecipazione getStatopartecipazione() {
        return statopartecipazione;
    }

    public void setStatopartecipazione(StatoPartecipazione statopartecipazione) {
        this.statopartecipazione = statopartecipazione;
    }

    public String getIdea_impresa() {
        return idea_impresa;
    }

    public void setIdea_impresa(String idea_impresa) {
        this.idea_impresa = idea_impresa;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getData_up() {
        return data_up;
    }

    public void setData_up(Date data_up) {
        this.data_up = data_up;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public Condizione_Lavorativa getCondizione_lavorativa() {
        return condizione_lavorativa;
    }

    public void setCondizione_lavorativa(Condizione_Lavorativa condizione_lavorativa) {
        this.condizione_lavorativa = condizione_lavorativa;
    }

    public double getOre_fa() {
        return ore_fa;
    }

    public double getOre_fb() {
        return ore_fb;
    }

    public void setOre_fa(double ore_fa) {
        this.ore_fa = ore_fa;
    }

    public void setOre_fb(double ore_fb) {
        this.ore_fb = ore_fb;
    }

    public double getImporto() {
        return importo;
    }

    public void setImporto(double importo) {
        this.importo = importo;
    }

    public String getPrivacy2() {
        return privacy2;
    }

    public void setPrivacy2(String privacy2) {
        this.privacy2 = privacy2;
    }

    public String getPrivacy3() {
        return privacy3;
    }

    public void setPrivacy3(String privacy3) {
        this.privacy3 = privacy3;
    }

    public String getStato_nascita() {
        return stato_nascita;
    }

    public void setStato_nascita(String stato_nascita) {
        this.stato_nascita = stato_nascita;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        if (!(object instanceof Allievi)) {
            return false;
        }
        Allievi other = (Allievi) object;
        return !((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id)));
    }

    @Override
    public String toString() {
        return "Allievi{" + "id=" + id + ", nome=" + nome + ", cognome=" + cognome + '}';
    }
}
