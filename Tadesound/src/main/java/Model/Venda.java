package Model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Venda {
    
    //Construtor sem a data da venda
    public Venda (String tipo, String valorTotal, int quantidadeProdutos, String dataEntrega, int idCliente, int idFuncionario) {
        this.tipo = tipo;
        this.valorTotal = valorTotal;
        this.quantidadeProdutos = quantidadeProdutos;
        this.dataEntrega = dataEntrega;
        this.idCliente = idCliente;
        this.idFuncionario = idFuncionario;
    }
    
    //Construtor com a data da venda
    public Venda (int idVenda, String tipo, String valorTotal, int quantidadeProdutos, int idCliente, int idFuncionario, String dataVenda) {
        this.idVenda = idVenda;
        this.tipo = tipo;
        this.valorTotal = valorTotal;
        this.quantidadeProdutos = quantidadeProdutos;
        this.idCliente = idCliente;
        this.idFuncionario = idFuncionario;
        this.dataVenda = dataVenda;
    }
    
    //Construtor sem a data de entrega
    public Venda(String tipo, String valorTotal, int quantidadeProdutos, int idCliente, int idFuncionario) {
        this.tipo = tipo;
        this.valorTotal = valorTotal;
        this.quantidadeProdutos = quantidadeProdutos;
        this.idCliente = idCliente;
        this.idFuncionario = idFuncionario;
    }
    
    private int idVenda;
    private String tipo;
    private String valorTotal;
    private int quantidadeProdutos;
    private String dataEntrega;
    private String dataRetirada;
    private int idCliente;
    private int idFuncionario;
    private String dataVenda;
}
