/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rc.so.domain;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
 *
 * @author dolivo
 */
@Entity
@Table(name="stato_partecipazione")
@NamedQueries(value = {
    @NamedQuery(name = "sp.Elenco", query = "select sp from StatoPartecipazione sp ORDER BY sp.id"),
    @NamedQuery(name = "sp.Elencomod", query = "select sp from StatoPartecipazione sp WHERE sp.id<>'01'"),
    @NamedQuery(name = "sp.modificaincorso", query = "select sp from StatoPartecipazione sp WHERE sp.id IN ('15','11','16','17')"),
})

public class StatoPartecipazione implements Serializable {

    @Column(name = "codice")
    @Id
    private String id;

    @Column(name = "descrizione")
    private String descrizione;

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

    public StatoPartecipazione() {
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
        if (!(object instanceof StatoPartecipazione)) {
            return false;
        }
        StatoPartecipazione other = (StatoPartecipazione) object;
        return !((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id)));
    }

    @Override
    public String toString() {
        return "StatoPartecipazione{" + "id=" + id + ", descrizione=" + descrizione + '}';
    }

}
