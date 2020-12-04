package Model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SessaoVendaServicosModel {
    
    public SessaoVendaServicosModel(int idServico, String nomeServico, int duracaoMinutos, int grauComplexidade, String valorTotal, String dataProrgramada) {
        this.idServico = idServico;
        this.nomeServico = nomeServico;
        this.duracaoMinutos = duracaoMinutos;
        this.grauComplexidade = grauComplexidade;
        this.valorTotal = valorTotal;
        this.dataProrgramada = dataProrgramada;
    }
    
    private int idServico;
    private String nomeServico;
    private int duracaoMinutos;
    private int grauComplexidade;
    private String valorTotal;
    private String dataProrgramada;
}
