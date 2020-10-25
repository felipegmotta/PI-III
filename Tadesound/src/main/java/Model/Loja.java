
package Model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class Loja {

    //Construtor já com a data de cadastro
    public Loja(int idLoja, String nomeLoja, String endereco, int numeroLoja, String bairro, String complemento, String cidade, String uf, String cep, String telefone, String dataCadastro) {
        this.idLoja = idLoja;
        this.nomeLoja = nomeLoja;
        this.endereco = endereco;
        this.numeroLoja = numeroLoja;
        this.bairro = bairro;
        this.complemento = complemento;
        this.cidade = cidade;
        this.uf = uf;
        this.cep = cep;
        this.telefone = telefone;
        this.dataCadastro = dataCadastro;
    }
    
    //Construtor sem data de cadastro
    public Loja(int idLoja, String nomeLoja, String endereco, int numeroLoja, String bairro, String complemento, String cidade, String uf, String cep, String telefone) {
        this.idLoja = idLoja;
        this.nomeLoja = nomeLoja;
        this.endereco = endereco;
        this.numeroLoja = numeroLoja;
        this.bairro = bairro;
        this.complemento = complemento;
        this.cidade = cidade;
        this.uf = uf;
        this.cep = cep;
        this.telefone = telefone;
    }

    //Construtor sem o id da loja
    public Loja(String nomeLoja, String endereco, int numeroLoja, String bairro, String complemento, String cidade, String uf, String cep, String telefone, String dataCadastro) {
        this.nomeLoja = nomeLoja;
        this.endereco = endereco;
        this.numeroLoja = numeroLoja;
        this.bairro = bairro;
        this.complemento = complemento;
        this.cidade = cidade;
        this.uf = uf;
        this.cep = cep;
        this.telefone = telefone;
        this.dataCadastro = dataCadastro;
    }
    
    private int idLoja;
    private String nomeLoja;
    private String endereco;
    private int numeroLoja;
    private String bairro;
    private String complemento;
    private String cidade;
    private String uf;
    private String cep;
    private String telefone;
    private String dataCadastro; 
}
