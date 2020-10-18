package Model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Cliente extends Pessoa {
    
    //Construtor sem a data de cadastro
    public Cliente(String nome, String email, String cpf, String dataNascimento, String telefone, String endereco, int numero, String complemento, String bairro, String cidade, String uf, String cep) {
        super(nome, email, cpf, dataNascimento, telefone, endereco, numero, complemento, bairro, cidade, uf, cep);
    }
    
    //Construtor com a data de cadastro
    public Cliente(String nome, String email, String cpf, String dataNascimento, String telefone, String endereco, int numero, String complemento, String bairro, String cidade, String uf, String cep, String dataCadastro) {
        super(nome, email, cpf, dataNascimento, telefone, endereco, numero, complemento, bairro, cidade, uf, cep);
        this.dataCadastro = dataCadastro;
    }
    
    //Construtor com o idCliente
    public Cliente(int idCliente, String nome, String email, String cpf, String dataNascimento, String telefone, String endereco, int numero, String complemento, String bairro, String cidade, String uf, String cep) {
        super(nome, email, cpf, dataNascimento, telefone, endereco, numero, complemento, bairro, cidade, uf, cep);
        this.idCliente = idCliente;
    }
    
    private String dataCadastro;
    private int idCliente;
}
