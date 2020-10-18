/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

/**
 *
 * @author Edu Franco
 */

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Produto {
    
    private int idProduto;
    private String nomeProduto;
    private String descricaoProduto;
    private double precoProduto;
    private String categoriaProduto;
    private int quantidadeProduto;
    /*
    Conversar com time sobre esses atributos.
    private String nomeFornecedor;
    private String nomeLoja;
    private String dataCadastro;
    private String ultimaAtualizacao;
    */

    //Construtor do produto
    public Produto(int idProduto, String nomeProduto, String descricaoProduto, double precoProduto, String categoriaProduto, int quantidadeProduto) {
        this.idProduto = idProduto;
        this.nomeProduto = nomeProduto;
        this.descricaoProduto = descricaoProduto;
        this.precoProduto = precoProduto;
        this.categoriaProduto = categoriaProduto;
        this.quantidadeProduto = quantidadeProduto;
        
        /*
        Conversar com o time sobre esses atributos.
        this.nomeFornecedor = nomeFornecedor;
        this.nomeLoja = nomeLoja;
        this.dataCadastro = dataCadastro;
        this.ultimaAtualizacao = ultimaAtualizacao;
        */
        
    }
    
    
    
}
