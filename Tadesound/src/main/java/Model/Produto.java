package Model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Produto {
    
    //Construtor sem a data de cadastro
    public Produto(String nome, String descricao, String preco, String categoria, int quantidadeEstoque, int idFornecedor, int idLoja) {
        this.nome = nome;
        this.descricao = descricao;
        this.preco = preco;
        this.categoria = categoria;
        this.quantidadeEstoque = quantidadeEstoque;
        this.idFornecedor = idFornecedor;
        this.idLoja = idLoja;
    }
    
    //Construtor com a data de cadastro
    public Produto(int idProduto, String nome, String descricao, String preco, String categoria, int quantidadeEstoque, int idFornecedor, int idLoja, String dataCadastro) {
        this.idProduto = idProduto;
        this.nome = nome;
        this.descricao = descricao;
        this.preco = preco;
        this.categoria = categoria;
        this.quantidadeEstoque = quantidadeEstoque;
        this.idFornecedor = idFornecedor;
        this.idLoja = idLoja;
        this.dataCadastro = dataCadastro;
    }
    
    //Construtor com o idProduto
    public Produto(int idProduto, String nome, String descricao, String preco, String categoria, int quantidadeEstoque, int idFornecedor, int idLoja) {
        this.idProduto = idProduto;
        this.nome = nome;
        this.descricao = descricao;
        this.preco = preco;
        this.categoria = categoria;
        this.quantidadeEstoque = quantidadeEstoque;
        this.idFornecedor = idFornecedor;
        this.idLoja = idLoja;
    }
    
    //Construtor para o produto na sessao do usuario
    public Produto(int idProduto, String nome, String categoria, int quantidadeProduto, String preco, String precoTotalProduto) {
        this.idProduto = idProduto;
        this.nome = nome;
        this.categoria = categoria;
        this.quantidadeProduto = quantidadeProduto;
        this.preco = preco;
        this.precoTotalProduto = precoTotalProduto;
    }
    
    private int idProduto;
    private String nome;
    private String descricao;
    private String preco;
    private String categoria;
    private int quantidadeEstoque;
    private int idFornecedor;
    private int idLoja;
    private String dataCadastro;    
    
    //Para adicionar produtos na sessao
    private String precoTotalProduto;
    private int quantidadeProduto;
}
