package Model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Venda {

    //Construtor sem a data programada
    public Venda(String tipo, String valorTotal, int quantidadeItens, int idCliente, int idFuncionario) {
        this.tipo = tipo;
        this.valorTotal = valorTotal;
        this.quantidadeItens = quantidadeItens;
        this.idCliente = idCliente;
        this.idFuncionario = idFuncionario;
    }
    
    //Construtor com a data programada
    public Venda(String tipo, String valorTotal, int quantidadeItens, int idCliente, int idFuncionario, String dataProgramada) {
        this.tipo = tipo;
        this.valorTotal = valorTotal;
        this.quantidadeItens = quantidadeItens;
        this.idCliente = idCliente;
        this.idFuncionario = idFuncionario;
        this.dataProgramada = dataProgramada;
    }

    //Construtor com a data da venda
    public Venda(int idVenda, String tipo, String valorTotal, int quantidadeItens, int idCliente, int idFuncionario, String dataVenda) {
        this.idVenda = idVenda;
        this.tipo = tipo;
        this.valorTotal = valorTotal;
        this.quantidadeItens = quantidadeItens;
        this.idCliente = idCliente;
        this.idFuncionario = idFuncionario;
        this.dataVenda = dataVenda;
    }

    private int idVenda;
    private String tipo;
    private String valorTotal; //<-- Valor unitario, to com preguica de renomear a variavel
    private int quantidadeItens;
    private int idCliente;
    private int idFuncionario;
    private String dataProgramada;
    private String dataVenda;
}
