/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rc.so.domain;

import java.io.Serializable;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;

/**
 * @author smo
 */
@Entity
@Table(name = "attivita")
@NamedQueries(value = {
    @NamedQuery(name = "attivita.Valide", query = "select a from Attivita a where a.latitutdine>0 and a.longitudine>0 ORDER BY a.comune.provincia"),})
public class Attivita implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    @Column(name = "idattivita")
    private Long id;
    @Column(name = "nome")
    private String name;
    @Column(name = "latitutdine")
    private double latitutdine;
    @Column(name = "longitudine")
    private double longitudine;

    @ManyToOne
    @JoinColumn(name = "comune")
    private Comuni comune;

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getLatitutdine() {
        return latitutdine;
    }

    public void setLatitutdine(double latitutdine) {
        this.latitutdine = latitutdine;
    }

    public double getLongitudine() {
        return longitudine;
    }

    public void setLongitudine(double longitudine) {
        this.longitudine = longitudine;
    }

    public Comuni getComune() {
        return comune;
    }

    public void setComune(Comuni comune) {
        this.comune = comune;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Attivita)) {
            return false;
        }
        Attivita other = (Attivita) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "rc.so.domain.Attivita[ id=" + id + " ]";
    }

}
