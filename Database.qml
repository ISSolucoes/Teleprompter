import QtQuick
import QtQuick.LocalStorage

Item {
    property var db

    function initDatabase() {
        console.log("initDatabase()");
        db = LocalStorage.openDatabaseSync("Textos", "1.0", "Banco de dados de textos do usuário", 250000000);
        db.transaction(function(tx) {
            console.log("Create table");
            tx.executeSql('CREATE TABLE IF NOT EXISTS textos(titulo TEXT, texto TEXT)');
        });
    }

    function storeData(textoASerSalvo) {
        console.log("storeData()");
        if( !db ) { return }

        db.transaction(function(tx){
            console.log("Salvando item na tabela textos");
            let resultado = tx.executeSql('INSERT INTO textos VALUES (?,?)', [textoASerSalvo.titulo, textoASerSalvo.texto]);
        });
    }

    function updateData(indice, textoASerSalvo) {
        console.log("updateData()");
        if( !db ) { return }

        db.transaction(function(tx){
            console.log(`Atualizando item na tabela textos pelo indice: ${indice}`);
            let resultado = tx.executeSql(`UPDATE textos set texto=? where _id="${indice}"`, [textoASerSalvo.texto]); // supondo que o id em textoModel(ListModel) é igual ao id no banco de dados
        });
    }

    function readData() {
        let vetorTextos = [];
        console.log("readData()");
        if( !db ) { return }
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

    Component.onCompleted: function() {
        //initDatabase();
        //readData(); // a se fazer apenas quando o componente Textos iniciar
    }

    Component.onDestruction: function() {
        //storeData();
    }

}
