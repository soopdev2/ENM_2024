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
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.persistence.Transient;

/**
 *
 * @author smo
 */
@Entity
@Table(name = "allievi")
@NamedQueries(value = {
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
    @Column(name = "esclusione_prg")
    private String esclusione_prg;
    @Temporal(TemporalType.DATE)
    @Column(name = "iscrizione")
    private Date iscrizione;
    @Column(name = "datacpi")
    @Temporal(TemporalType.DATE)
    private Date datacpi;
    @Column(name = "docid")
    private String docid;
    @Column(name = "scadenzadocid")
    @Temporal(TemporalType.DATE)
    private Date scadenzadocid;
    @Column(name = "email")
    private String email;
    @Column(name = "sesso")
    private String sesso;
    @Column(name = "telefono")
    private String telefono;
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
    @ManyToOne
    @JoinColumn(name = "idcondizione_mercato")
    private Condizione_Mercato condizione_mercato;
    @ManyToOne
    @JoinColumn(name = "id_statopartecipazione")
    private StatoPartecipazione statopartecipazione;
    @ManyToOne
    @JoinColumn(name = "idcondizione_lavorativa")
    private Condizione_Lavorativa condizione_lavorativa;
    @ManyToOne
    @JoinColumn(name = "motivazione")
    private Motivazione motivazione;
    @ManyToOne
    @JoinColumn(name = "idcanale")
    private Canale canale;
    @OneToMany(mappedBy = "allievo", fetch = FetchType.LAZY)
    List<Documenti_Allievi> documenti;

    //Gruppo modello 4
    @Column(name = "gruppo_faseB")
    private int gruppo_faseB;
    
    @Column(name = "statoallievo")
    private String statoallievo;
    
    public Allievi() {
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

    public String getStatoallievo() {
        return statoallievo;
    }

    public void setStatoallievo(String statoallievo) {
        this.statoallievo = statoallievo;
    }
    
    public List<Documenti_Allievi> getDocumenti() {
        List<Documenti_Allievi> docs = new ArrayList<>();//per fixare il bug dello stream  per le lazy list di EclipseLink
        docs.addAll(this.documenti);
        return docs;
    }

    public void setDocumenti(List<Documenti_Allievi> documenti) {
        this.documenti = documenti;
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
        StringBuilder sb = new StringBuilder();
        sb.append("Allievi{");
        sb.append("id=").append(id);
        sb.append(", nome=").append(nome);
        sb.append(", cognome=").append(cognome);
        sb.append(", codicefiscale=").append(codicefiscale);
        sb.append(", datanascita=").append(datanascita);
        sb.append(", indirizzodomicilio=").append(indirizzodomicilio);
        sb.append(", indirizzoresidenza=").append(indirizzoresidenza);
        sb.append(", civicodomicilio=").append(civicodomicilio);
        sb.append(", civicoresidenza=").append(civicoresidenza);
        sb.append(", esclusione_prg=").append(esclusione_prg);
        sb.append(", iscrizione=").append(iscrizione);
        sb.append(", datacpi=").append(datacpi);
        sb.append(", docid=").append(docid);
        sb.append(", scadenzadocid=").append(scadenzadocid);
        sb.append(", email=").append(email);
        sb.append(", sesso=").append(sesso);
        sb.append(", telefono=").append(telefono);
        sb.append(", data_up=").append(data_up);
        sb.append(", cittadinanza=").append(cittadinanza);
        sb.append(", comune_nascita=").append(comune_nascita);
        sb.append(", comune_residenza=").append(comune_residenza);
        sb.append(", comune_domicilio=").append(comune_domicilio);
        sb.append(", titoloStudio=").append(titoloStudio);
        sb.append(", progetto=").append(progetto);
        sb.append(", soggetto=").append(soggetto);
        sb.append(", cpi=").append(cpi);
        sb.append(", stato_nascita=").append(stato_nascita);
        sb.append(", privacy2=").append(privacy2);
        sb.append(", privacy3=").append(privacy3);
        sb.append(", condizione_mercato=").append(condizione_mercato);
        sb.append(", statopartecipazione=").append(statopartecipazione);
        sb.append(", condizione_lavorativa=").append(condizione_lavorativa);
        sb.append(", motivazione=").append(motivazione);
        sb.append(", canale=").append(canale);
        sb.append(", gruppo_faseB=").append(gruppo_faseB);
        sb.append('}');
        return sb.toString();
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCognome() {
        return cognome;
    }

    public void setCognome(String cognome) {
        this.cognome = cognome;
    }

    public String getCodicefiscale() {
        return codicefiscale;
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

    public String getEsclusione_prg() {
        return esclusione_prg;
    }

    public void setEsclusione_prg(String esclusione_prg) {
        this.esclusione_prg = esclusione_prg;
    }

    public Date getIscrizione() {
        return iscrizione;
    }

    public void setIscrizione(Date iscrizione) {
        this.iscrizione = iscrizione;
    }

    public Date getDatacpi() {
        return datacpi;
    }

    public void setDatacpi(Date datacpi) {
        this.datacpi = datacpi;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSesso() {
        return sesso;
    }

    public void setSesso(String sesso) {
        this.sesso = sesso;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public Date getData_up() {
        return data_up;
    }

    public void setData_up(Date data_up) {
        this.data_up = data_up;
    }

    public Nazioni_rc getCittadinanza() {
        return cittadinanza;
    }

    public void setCittadinanza(Nazioni_rc cittadinanza) {
        this.cittadinanza = cittadinanza;
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

    public SoggettiAttuatori getSoggetto() {
        return soggetto;
    }

    public void setSoggetto(SoggettiAttuatori soggetto) {
        this.soggetto = soggetto;
    }

    public CPI getCpi() {
        return cpi;
    }

    public void setCpi(CPI cpi) {
        this.cpi = cpi;
    }

    public String getStato_nascita() {
        return stato_nascita;
    }

    public void setStato_nascita(String stato_nascita) {
        this.stato_nascita = stato_nascita;
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

    public Condizione_Mercato getCondizione_mercato() {
        return condizione_mercato;
    }

    public void setCondizione_mercato(Condizione_Mercato condizione_mercato) {
        this.condizione_mercato = condizione_mercato;
    }

    public StatoPartecipazione getStatopartecipazione() {
        return statopartecipazione;
    }

    public void setStatopartecipazione(StatoPartecipazione statopartecipazione) {
        this.statopartecipazione = statopartecipazione;
    }

    public Condizione_Lavorativa getCondizione_lavorativa() {
        return condizione_lavorativa;
    }

    public void setCondizione_lavorativa(Condizione_Lavorativa condizione_lavorativa) {
        this.condizione_lavorativa = condizione_lavorativa;
    }

    public Motivazione getMotivazione() {
        return motivazione;
    }

    public void setMotivazione(Motivazione motivazione) {
        this.motivazione = motivazione;
    }

    public Canale getCanale() {
        return canale;
    }

    public void setCanale(Canale canale) {
        this.canale = canale;
    }

    public int getGruppo_faseB() {
        return gruppo_faseB;
    }

    public void setGruppo_faseB(int gruppo_faseB) {
        this.gruppo_faseB = gruppo_faseB;
    }

    
}
