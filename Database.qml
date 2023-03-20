import QtQuick
import QtQuick.LocalStorage

Item {
    property var db
    signal emiteTextoUsado(string texto);

    function initDatabase() {
        console.log("initDatabase()");
        db = LocalStorage.openDatabaseSync("Textos", "1.0", "Banco de dados de textos do usuário", 250000000);
        db.transaction(function(tx) {
            console.log("Create table");
            tx.executeSql('CREATE TABLE IF NOT EXISTS textos(titulo TEXT, texto TEXT, isUsed INT)'); // automaticamente o sqlite cria a coluna rowid
            //const resultadoDropTable = tx.executeSql('DROP TABLE IF EXISTS textos');
        });
    }

    function storeData(textoASerSalvo) {
        console.log("storeData()");

        if( !db ) {
            console.log("Banco de dados não iniciado!");
            return;
        }

        db.transaction(function(tx){
            console.log("Salvando item na tabela textos");
            let resultado = tx.executeSql('INSERT INTO textos (titulo, texto, isUsed) VALUES (?,?,?)', [textoASerSalvo.titulo, textoASerSalvo.texto, 0]);
        });
    }

    function updateData(indiceNoListModel, textoASerSalvo) {
        console.log("updateData()");

        if( !db ) {
            console.log("Banco de dados não iniciado!");
            return;
        }

        let indiceNoBD = ++indiceNoListModel; // o indice no ListModel começa pelo 0. Já no DB, o id se inicia pelo 1. Incrementamos uma vez para alinhar
        // o item na View com o item no banco.

        db.transaction(function(tx){
            console.log(`Atualizando item na tabela textos pelo indice no banco: ${indiceNoBD}`);
            const resultado = tx.executeSql(`UPDATE textos set titulo=?, texto=? where rowid="${indiceNoBD}"`, [textoASerSalvo.titulo, textoASerSalvo.texto]); // supondo que o id em textoModel(ListModel) é igual ao id no banco de dados
            console.log("Operação bem sucedida");
        });
    }

    function usarTexto(indiceNoListModel) {
        console.log("usarTexto()");

        if( !db ) {
            console.log("Banco de dados não iniciado");
            return;
        }

        let indiceNoBD = ++indiceNoListModel;

        db.transaction(function(tx){
            console.log(`Atualizando item na tabela textos pelo indice no banco: ${indiceNoBD}. Para ser usado no teleprompter`);
            const resultadoSetAll0 = tx.executeSql(`UPDATE textos set isUsed=?`, [0]);
            let resultado = tx.executeSql(`UPDATE textos set isUsed=? where rowid="${indiceNoBD}"`, [1]);
            let resultadoSelect = tx.executeSql(`select * from textos where rowid="${indiceNoBD}"`);
            console.log(resultadoSelect.rows[0].texto);
            let texto = resultadoSelect.rows[0].texto;
            emiteTextoUsado(texto);
        });

    }

    function readData() {
        let vetorTextos = [];
        console.log("readData()");

        if( !db ) {
            console.log("Banco de dados não iniciado!");
            return;
        }

        db.transaction(function(tx) {
            console.log(`Lendo textos do banco "Textos", na tabela "textos"`);
            const resultado = tx.executeSql('select * from textos');
            let linhas = resultado.rows;
            if( linhas.length === 0 ) {
                console.log("Nenhum dado na tabela");
            } else if( linhas.length >= 1 ) {
                console.log("No minimo um dado na tabela");

                for(let indice = 0; indice < linhas.length; indice++) {
                    const objetoTexto = linhas[indice];
                    vetorTextos.push(objetoTexto);
                }
            }
        });
        return vetorTextos;
    }

    function deleteAll() {
        console.log("deleteAll()")
        if( !db ) {
            console.log("Banco de dados não iniciado!");
            return;
        }

        db.transaction(function(tx) {
            console.log("Deletando todos os itens");
            const resultado = tx.executeSql('DELETE FROM textos');
        });

    }

    Component.onCompleted: function() {
        //initDatabase();
        //readData(); // a se fazer apenas quando o componente Textos iniciar
    }

    Component.onDestruction: function() {
        //storeData();
    }

}
