/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rc.so.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import java.io.Serializable;
import java.util.List;
import java.util.Objects;
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
import javax.persistence.Transient;

/**
 *
 * @author smo
 */
@Entity
@Table(name = "sedi_formazione")
@NamedQueries(value = {
    @NamedQuery(name = "s.Active", query = "SELECT s FROM SediFormazione s WHERE s.stato='A' OR s.stato='A1'"),
    @NamedQuery(name = "s.active.soggetto", query = "SELECT s FROM SediFormazione s WHERE (s.stato='A' OR s.stato='A1') AND s.soggetto=:soggetto"),
    @NamedQuery(name = "s.byProgetto", query = "SELECT s FROM SediFormazione s WHERE s.progetti=:progetto")
})
@JsonIgnoreProperties(value = {"progetti"})
public class SediFormazione implements Serializable {

    @Id
    @Column(name = "idsedi")
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long id;
    @Column(name = "denominazione")
    private String denominazione;
    @Column(name = "indirizzo")
    private String indirizzo;
    @Column(name = "referente")
    private String referente;
    @Column(name = "telefono")
    private String telefono;
    @Column(name = "cellulare")
    private String cellulare;
    @Column(name = "email")
    private String email;

    @ManyToOne
    @JoinColumn(name = "comune")
    private Comuni comune;

    @OneToMany(mappedBy = "sede", fetch = FetchType.LAZY)
    List<ProgettiFormativi> progetti;

    @ManyToOne
    @JoinColumn(name = "idsoggetti_attuatori")
    SoggettiAttuatori soggetto;

    @Column(name = "stato")
    private String stato = "DV";

    @Transient
    String descrizionestato;

    public SediFormazione() {
    }

    public SediFormazione(String denominazione, String indirizzo, String referente, String telefono, String cellulare, String email, Comuni comune) {
        this.denominazione = denominazione;
        this.indirizzo = indirizzo;
        this.referente = referente;
        this.telefono = telefono;
        this.cellulare = cellulare;
        this.email = email;
        this.comune = comune;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public SoggettiAttuatori getSoggetto() {
        return soggetto;
    }

    public void setSoggetto(SoggettiAttuatori soggetto) {
        this.soggetto = soggetto;
    }

    public String getDenominazione() {
        return denominazione;
    }

    public void setDenominazione(String denominazione) {
        this.denominazione = denominazione;
    }

    public String getIndirizzo() {
        return indirizzo;
    }

    public void setIndirizzo(String indirizzo) {
        this.indirizzo = indirizzo;
    }

    public String getReferente() {
        return referente;
    }

    public void setReferente(String referente) {
        this.referente = referente;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getCellulare() {
        return cellulare;
    }

    public void setCellulare(String cellulare) {
        this.cellulare = cellulare;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Comuni getComune() {
        return comune;
    }

    public void setComune(Comuni comune) {
        this.comune = comune;
    }

    public List<ProgettiFormativi> getProgetti() {
        return progetti;
    }

    public void setProgetti(List<ProgettiFormativi> progetti) {
        this.progetti = progetti;
    }

    public String getStato() {
        return stato;
    }

    public void setStato(String stato) {
        this.stato = stato;
    }

    public String getDescrizionestato() {
        if (this.stato == null) {
            return "";
        } else if (this.stato.equals("A")) {
            return "ACCREDITATA";
        } else if (this.stato.equals("A1")) {
            return "ACCREDITATA PER MASSIMO 8 ALLIEVI";
        } else if (this.stato.equals("DV")) {
            return "DA VALIDARE";
        } else if (this.stato.equals("R")) {
            return "RIGETTATA";
        }
        return "";
    }

    public void setDescrizionestato() {
        if (this.stato == null) {
            this.descrizionestato = "";
        } else if (this.stato.equals("A")) {
            this.descrizionestato = "ACCREDITATA";
        } else if (this.stato.equals("A1")) {
            this.descrizionestato = "ACCREDITATA PER MASSIMO 8 ALLIEVI";
        } else if (this.stato.equals("DV")) {
            this.descrizionestato = "DA VALIDARE";
        } else if (this.stato.equals("R")) {
            this.descrizionestato = "RIGETTATA";
        }
        this.descrizionestato = "";
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 41 * hash + Objects.hashCode(this.id);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final SediFormazione other = (SediFormazione) obj;
        if (!Objects.equals(this.id, other.id)) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "SediFormazione{" + "id=" + id + ", denominazione=" + denominazione + ", indirizzo=" + indirizzo + ", referente=" + referente + ", telefono=" + telefono + ", cellulare=" + cellulare + ", email=" + email + ", comune=" + comune + ", progetti=" + progetti + '}';
    }

}
