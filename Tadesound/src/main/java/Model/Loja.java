/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
/**
 *
 * @author Edu Franco
 */
public class Loja {

    //Construtor já com a data de cadastro
    public Loja(int idLoja, String nomeLoja, String endereco, int numeroLoja, String bairro, String complemento, String cidade, String uf, int cep, int telefone, String dataCadastro) {
        this.idLoja = idLoja;
        this.nomeLoja = nomeLoja;
        this.endereco = endereco;
        this.numeroLoja = numeroLoja;
        this.bairro = bairro;
        this.complemento = complemento;
        this.cidade = cidade;
        this.uf = uf;
        this.cep = cep;
        this.telefone = telefone;
        this.dataCadastro = dataCadastro;
    }
    
    //Construtor sem data de cadastro
    public Loja(int idLoja, String nomeLoja, String endereco, int numeroLoja, String bairro, String complemento, String cidade, String uf, int cep, int telefone) {
        this.idLoja = idLoja;
        this.nomeLoja = nomeLoja;
        this.endereco = endereco;
        this.numeroLoja = numeroLoja;
        this.bairro = bairro;
        this.complemento = complemento;
        this.cidade = cidade;
        this.uf = uf;
        this.cep = cep;
        this.telefone = telefone;
    }

    private int idLoja;
    private String nomeLoja;
    private String endereco;
    private int numeroLoja;
    private String bairro;
    private String complemento;
    private String cidade;
    private String uf;
    private int cep;
    private int telefone;
    private String dataCadastro;
    
    
    
    
}
