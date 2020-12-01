package Model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SessaoVendaProdutosModel {
    
    public SessaoVendaProdutosModel(int idProduto, String nome, String categoria, int quantidadeProduto, String preco, String precoTotalProduto) {
        this.idProduto = idProduto;
        this.nome = nome;
        this.categoria = categoria;
        this.quantidadeProduto = quantidadeProduto;
        this.preco = preco;
        this.precoTotalProduto = precoTotalProduto;
    }
    
    private int idProduto;
    private String nome;
    private String categoria;
    private int quantidadeProduto;
    private String preco;
    private String precoTotalProduto;
}
