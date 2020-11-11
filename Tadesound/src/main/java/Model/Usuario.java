package Model;

import at.favre.lib.crypto.bcrypt.BCrypt;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Usuario {
    
    //Construtor sem a data de cadastro
    public Usuario(int idUsuario, String nome, String login, String senha, String cargo, int idFuncionario, String dataCadastro) {
        this.nome = nome;
        this.idUsuario = idUsuario;
        this.login = login;
        this.senha = senha;
        this.cargo = cargo;
        this.idFuncionario = idFuncionario;
        this.dataCadastro = dataCadastro;
    }
    
    private int idUsuario;
    private String nome;
    private String login;
    private String senha;
    private String cargo;
    private int idFuncionario;
    private String dataCadastro;
    
    public String codificarSenha(String senha){
        return BCrypt.withDefaults().hashToString(12, senha.toCharArray());
    }
    
    public boolean validarSenha(String senha) {
        BCrypt.Result response = BCrypt.verifyer().verify(senha.toCharArray(), this.senha);
        return response.verified;
    }
    
    public boolean isAdmin() {
        return this.cargo.equalsIgnoreCase("admin");
    }
    
    public boolean isVendedor() {
        return this.cargo.equalsIgnoreCase("vendedor");
    }
    
    public boolean isBackoffice() {
        return this.cargo.equalsIgnoreCase("backoffice");
    }
    
    public boolean isGerente() {
        return this.cargo.equalsIgnoreCase("gerente");
    }
}
