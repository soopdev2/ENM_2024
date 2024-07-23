/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rc.so.domain;

import java.io.Serializable;
import java.util.Objects;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;

/**
 *
 * @author smo
 */
@Entity
@Table(name = "ateco")
@NamedQueries(value = {
    @NamedQuery(name = "ate.Elenco", query = "select ate from Ateco ate ORDER BY ate.id")
})

public class Ateco implements Serializable {
    @Column(name = "codice")
    @Id
    private String id;

    @Column(name = "descrizione")
    private String descrizione;

    public Ateco() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDescrizione() {
        return descrizione;
    }

    public void setDescrizione(String descrizione) {
        this.descrizione = descrizione;
    }

    @Override
    public int hashCode() {
        int hash = 3;
        hash = 17 * hash + Objects.hashCode(this.id);
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
        final Ateco other = (Ateco) obj;
        return Objects.equals(this.id, other.id);
    }

    @Override
    public String toString() {
        return "Ateco{" + "id=" + id + ", descrizione=" + descrizione + '}';
    }

    
}
