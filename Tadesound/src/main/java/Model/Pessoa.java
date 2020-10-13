package Model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Pessoa {
    
    //Construtor
    public Pessoa (String nome, String email, String cpf, String dataNascimento, String telefone, String endereco, int numero, String complemento, String bairro, String cidade, String uf, String cep) {
        this.nome = nome;
        this.email = email;
        this.cpf = cpf;
        this.dataNascimento = dataNascimento;
        this.telefone = telefone;
        this.endereco = endereco;
        this.numero = numero;
        this.complemento = complemento;
        this.bairro = bairro;
        this.cidade = cidade;
        this.uf = uf;
        this.cep = cep;
    }
    
    private String nome;
    private String email;
    private String cpf;
    private String dataNascimento;
    private String telefone;
    private String endereco;
    private int numero;
    private String complemento;
    private String bairro;
    private String cidade;
    private String uf;
    private String cep;
}
