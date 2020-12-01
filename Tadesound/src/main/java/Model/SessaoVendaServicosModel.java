package Model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SessaoVendaServicosModel {
    
    public SessaoVendaServicosModel(int idServico, String nome, int grauComplexidade, int duracaoMinutos) {
        this.idServico = idServico;
        this.nome = nome;
        this.grauComplexidade = grauComplexidade;
        this.duracaoMinutos = duracaoMinutos;
    }
    
    private int idServico;
    private String nome;
    private int grauComplexidade;
    private int duracaoMinutos;
}
