package Model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Servico {
    
    //Construtor sem a data de requisicao
    public Servico(String nome, String preco, String grauComplexidade, int duracaoMinutos, int idLoja) {
        this.nome = nome;
        this.preco = preco;
        this.grauComplexidade = grauComplexidade;
        this.duracaoMinutos = duracaoMinutos;
        this.idLoja = idLoja;
    }
    
    //Construtor com a data de requisicao
    public Servico(int idServico, String nome, String preco, String grauComplexidade, int duracaoMinutos, int idLoja) {
        this.idServico = idServico;
        this.nome = nome;
        this.preco = preco;
        this.grauComplexidade = grauComplexidade;
        this.duracaoMinutos = duracaoMinutos;
        this.idLoja = idLoja;
    }
    
    //Construtor com o idProduto
    public Servico(int idServico, String nome, String preco, String grauComplexidade, int duracaoMinutos, int idLoja, String dataCadastro) {
        this.idServico = idServico;
        this.nome = nome;
        this.preco = preco;
        this.grauComplexidade = grauComplexidade;
        this.duracaoMinutos = duracaoMinutos;
        this.idLoja = idLoja;
        this.dataCadastro = dataCadastro;
    }
    
    private int idServico;
    private String nome;
    private String preco;
    private String grauComplexidade;
    private int duracaoMinutos;
    private int idLoja;
    private String dataCadastro;    
}
