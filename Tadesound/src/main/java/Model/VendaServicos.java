package Model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class VendaServicos {   
    
    public VendaServicos(int idServico, String nomeServico, String valorServico, int grauComplexidade, int duracaoMinutos, int idLoja, String dataVenda) {
        this.tipoVenda = "Servico";
        this.idServico = idServico;
        this.nomeServico = nomeServico;
        this.valorServico = valorServico;
        this.grauComplexidade = grauComplexidade;
        this.duracaoMinutos = duracaoMinutos;
        this.idLoja = idLoja;
        this.dataVenda = dataVenda;
    }
    
    private String tipoVenda;
    private int idServico;
    private String nomeServico;
    private String valorServico;
    private int grauComplexidade;
    private int duracaoMinutos;
    private int idLoja;
    private String dataVenda;
}
