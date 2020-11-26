package Model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ItensVenda {
    
    //Construtor sem a data da venda
    public ItensVenda (String tipo, int idVenda, int idItem, int quantidadeProduto, String valorTotalProduto) {
        this.tipo = tipo;
        this.idVenda = idVenda;
        this.idItem = idItem;
        this.quantidadeProduto = quantidadeProduto;
        this.valorTotalProduto = valorTotalProduto;
    }
    
    private int idItensVenda;
    private String tipo;
    private int idVenda;
    private int idItem;
    private int quantidadeProduto;
    private String valorTotalProduto;
}
