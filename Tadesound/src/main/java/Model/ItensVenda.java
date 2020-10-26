package Model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ItensVenda {
    
    //Construtor sem a data da venda
    public ItensVenda (int idVenda, int idProduto, int quantidadeProduto, String valorTotalProduto) {
        this.idVenda = idVenda;
        this.idProduto = idProduto;
        this.quantidadeProduto = quantidadeProduto;
        this.valorTotalProduto = valorTotalProduto;
    }
    
    private int idItensVenda;
    private int idVenda;
    private int idProduto;
    private int quantidadeProduto;
    private String valorTotalProduto;
}
