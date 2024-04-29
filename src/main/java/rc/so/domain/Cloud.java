/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rc.so.domain;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
 *
 * @author smo
 */
@Entity
@Table(name = "cloud")
@NamedQueries(value = {
    @NamedQuery(name = "cloud.byTipo", query = "SELECT c FROM Cloud c WHERE c.tipo=:tipo AND c.attivo = 1")
}
)
public class Cloud implements Serializable {

    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    @Id
    @Column(name = "idmodello")
    private Long id;
    @Column(name = "nome")
    private String nome;
    @Column(name = "path")
    private String path;
    @Column(name = "visible")
    private String visible;
    @Column(name = "attivo", columnDefinition = "INT(1)")
    private int attivo;
    @Column(name = "tipo", columnDefinition = "INT(1)")
    private int tipo;
    
    public Cloud() {
    }

    public Cloud(String nome, String path) {
        this.nome = nome;
        this.path = path;
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

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getVisible() {
        return visible;
    }

    public void setVisible(String visible) {
        this.visible = visible;
    }

    public int getAttivo() {
        return attivo;
    }

    public void setAttivo(int attivo) {
        this.attivo = attivo;
    }

    public int getTipo() {
        return tipo;
    }

    public void setTipo(int tipo) {
        this.tipo = tipo;
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
        if (!(object instanceof Cloud)) {
            return false;
        }
        Cloud other = (Cloud) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Cloud{" + "id=" + id + ", nome=" + nome + ", path=" + path + '}';
    }

}
