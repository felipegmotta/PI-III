package Model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class VendaLojas {   
    
    public VendaLojas(int idLoja, String nomeLoja, String valorTotal, String valorTotalPorcentagem) {
        this.tipoVenda = "Loja";
        this.idLoja = idLoja;
        this.nomeLoja = nomeLoja;
        this.valorTotal = valorTotal;
        this.valorTotalPorcentagem = valorTotalPorcentagem;
    }
    
    private String tipoVenda;
    private int idLoja;
    private String nomeLoja;
    private String valorTotal;
    private String valorTotalPorcentagem;
}
