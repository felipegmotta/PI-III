package Model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class VendaClientes {   
    
    public VendaClientes(int idCliente, String nomeCliente, int idLoja, String nomeLoja, int idVenda, String valorTotal, String dataVenda) {
        this.tipoVenda = "Cliente";
        this.idCliente = idCliente;
        this.nomeCliente = nomeCliente;
        this.idLoja = idLoja;
        this.nomeLoja = nomeLoja;
        this.idVenda = idVenda;
        this.valorTotal = valorTotal;
        this.dataVenda = dataVenda;
    }
    
    private String tipoVenda;
    private int idCliente;
    private String nomeCliente;
    private int idLoja;
    private String nomeLoja;
    private int idVenda;
    private String valorTotal;
    private String dataVenda;
}
