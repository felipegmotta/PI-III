package Model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class VendaProdutos {   
    
    public VendaProdutos(int idProduto, String nomeProduto, String valorProduto, int quantidadeTotalProduto, String valorTotal, int idLoja, String dataVenda) {
        this.tipoVenda = "Produto";
        this.idProduto = idProduto;
        this.nomeProduto = nomeProduto;
        this.valorProduto = valorProduto;
        this.quantidadeTotalProduto = quantidadeTotalProduto;
        this.valorTotal = valorTotal;
        this.idLoja = idLoja;
        this.dataVenda = dataVenda;
    }
    
    private String tipoVenda;
    private int idProduto;
    private String nomeProduto;
    private String valorProduto;
    private int quantidadeTotalProduto;
    private String valorTotal;
    private int idLoja;
    private String dataVenda;
}
