/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rc.so.domain;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

/**
 *
 * @author rcosco
 */
@NamedQueries(value = {
    @NamedQuery(name = "estrazioni.timestampDesc", query = "SELECT e FROM Estrazioni e WHERE e.progetti LIKE 'E%' ORDER BY e.timestamp DESC"),
    @NamedQuery(name = "estrazioni.rendicontazione", query = "SELECT e FROM Estrazioni e WHERE e.progetti NOT LIKE 'E%' ORDER BY e.timestamp DESC")
})

@Entity
@Table(name = "estrazioni")
public class Estrazioni implements Serializable {

    @Id
    @Column(name = "idestrazione")
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long id;
    @Temporal(TemporalType.TIMESTAMP)
    @Column(columnDefinition = "TIMESTAMP CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP", name = "timestamp", insertable = false)
    private Date timestamp;
    @Column(name = "progetti", columnDefinition = "TEXT")
    private String progetti;
    @Column(name = "path")
    private String path;

    @Transient
    private String visualTime;

    public Estrazioni() {
    }
    
    public Estrazioni(Date timestamp, String progetti, String path) {
        this.timestamp = timestamp;
        this.progetti = progetti;
        this.path = path;
    }
    

    public String getVisualTime() {
        return visualTime;
    }

    public void setVisualTime(String visualTime) {
        this.visualTime = visualTime;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Date getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Date timestamp) {
        this.timestamp = timestamp;
    }

    public String getProgetti() {
        return progetti;
    }

    public void setProgetti(String progetti) {
        this.progetti = progetti;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
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
        if (!(object instanceof Estrazioni)) {
            return false;
        }
        Estrazioni other = (Estrazioni) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Estrazioni{" + "id=" + id + ", timestamp=" + timestamp + ", progetti=" + progetti + ", path=" + path + '}';
    }

}
