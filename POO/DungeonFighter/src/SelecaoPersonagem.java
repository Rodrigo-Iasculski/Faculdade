import java.awt.*;
import javax.swing.*;

public class SelecaoPersonagem {
    JLabel pergunta;
    JFrame janela;
    JPanel painelPrincipal;
    JPanel painelPersonagem;
    JPanel painelInferior;
    JButton botaoBarbaro;
    JButton botaoPaladino;
    JButton botaoGuerreiro;
    JButton botaoVoltar;

    public SelecaoPersonagem(Paineis multiplosPaineis) {
        // Configurando os botoes
        ImageIcon iconePergunta = new ImageIcon("Assets/textoPergunta.png");
        ImageIcon iconeBarbaro = new ImageIcon("Assets/botaoBarbaro.png");
        ImageIcon iconePaladino = new ImageIcon("Assets/botaoPaladino.png");
        ImageIcon iconeGuerreiro = new ImageIcon("Assets/botaoGuerreiro.png");
        ImageIcon iconeVoltar = new ImageIcon("Assets/textoVoltar.png");

        Image imagemPergunta = iconePergunta.getImage().getScaledInstance(1000, 150, Image.SCALE_SMOOTH);
        Image imagemBarbaro = iconeBarbaro.getImage().getScaledInstance(250, 500, Image.SCALE_SMOOTH);
        Image imagemPaladino = iconePaladino.getImage().getScaledInstance(270, 500, Image.SCALE_SMOOTH);
        Image imagemGuerreiro = iconeGuerreiro.getImage().getScaledInstance(250, 500, Image.SCALE_SMOOTH);
        Image imagemVoltar = iconeVoltar.getImage().getScaledInstance(250, 60, Image.SCALE_SMOOTH);

        ImageIcon iconePerguntaResize = new ImageIcon(imagemPergunta);
        ImageIcon iconeBarbaroResize = new ImageIcon(imagemBarbaro);
        ImageIcon iconePaladinoResize = new ImageIcon(imagemPaladino);
        ImageIcon iconeGuerreiroResize = new ImageIcon(imagemGuerreiro);
        ImageIcon iconeVoltarResize = new ImageIcon(imagemVoltar);

        pergunta = new JLabel(iconePerguntaResize);
        botaoBarbaro = new JButton(iconeBarbaroResize);
        botaoPaladino = new JButton(iconePaladinoResize);
        botaoGuerreiro = new JButton(iconeGuerreiroResize);
        botaoVoltar = new JButton(iconeVoltarResize);

        JButton[] botoesPersonagem = {botaoBarbaro, botaoPaladino, botaoGuerreiro, botaoVoltar};
        for(JButton b : botoesPersonagem) {
            b.setAlignmentY(Component.CENTER_ALIGNMENT);
            b.setBorderPainted(false);
            b.setContentAreaFilled(false);
            b.setFocusPainted(false);
        }

        // Painel dos personagens
        painelPersonagem = new JPanel();
        painelPersonagem.setLayout(new BoxLayout(painelPersonagem, BoxLayout.X_AXIS));
        painelPersonagem.setBackground(Color.BLACK);

        painelPersonagem.add(Box.createVerticalGlue());
        painelPersonagem.add(botaoBarbaro);
        painelPersonagem.add(Box.createVerticalStrut(20));
        painelPersonagem.add(botaoPaladino);
        painelPersonagem.add(Box.createVerticalStrut(20));
        painelPersonagem.add(botaoGuerreiro);
        painelPersonagem.add(Box.createVerticalGlue());

        // Painel de baixo com o botao 'voltar'
        painelInferior = new JPanel(new FlowLayout(FlowLayout.LEFT));
        painelInferior.add(botaoVoltar);
        painelInferior.setBackground(Color.BLACK);

        // Painel da tela com todos os outros paineis
        painelPrincipal = new JPanel();
        painelPrincipal.setLayout(new BorderLayout());
        painelPrincipal.add(pergunta,BorderLayout.NORTH);
        painelPrincipal.add(painelPersonagem,BorderLayout.CENTER);
        painelPrincipal.add(painelInferior,BorderLayout.SOUTH);
        painelPrincipal.setBackground(Color.BLACK);

        //Implementacao das acoes dos botoes usando a classe "Paineis", que contem o cardlayout
        JPanel painelComPaineis = multiplosPaineis.paineis;
        CardLayout cardLayout = multiplosPaineis.layoutPaineis;

        botaoVoltar.addActionListener(e -> cardLayout.show(painelComPaineis, "Painel do Menu"));

    }
}

