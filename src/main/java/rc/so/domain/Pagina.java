/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rc.so.domain;

import java.io.Serializable;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

/**
 *
 * @author smo
 */
@Entity
@Table(name = "pagina")
public class Pagina implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Column(name = "nome")
    private String nome;
    @Column(name = "permessi")
    private String permessi;

    public Pagina() {
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getPermessi() {
        return permessi;
    }

    public void setPermessi(String permessi) {
        this.permessi = permessi;
    }
    
    
}
