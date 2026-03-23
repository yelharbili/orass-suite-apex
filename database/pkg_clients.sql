CREATE OR REPLACE PACKAGE pkg_clients AS
    FUNCTION get_all RETURN CLOB;
END pkg_clients;
/

CREATE OR REPLACE PACKAGE BODY pkg_clients AS
    FUNCTION get_all RETURN CLOB IS
        v_json CLOB;
    BEGIN
        SELECT JSON_ARRAYAGG(
                   JSON_OBJECT(
                       'id' VALUE id,
                       'prenom' VALUE prenom,
                       'nom' VALUE nom,
                       'email' VALUE email,
                       'total_polices' VALUE total_polices,
                       'statut' VALUE statut
                   ) RETURNING CLOB
               ) INTO v_json
        FROM clients;
        
        RETURN NVL(v_json, '[]');
    END get_all;
END pkg_clients;
/
