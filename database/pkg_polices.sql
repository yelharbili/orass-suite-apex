CREATE OR REPLACE PACKAGE orassadm.pkg_polices AS
    -- Renvoie un JSON contenant toutes les polices avec les infos du client associé (Endpoint GET ORDS)
    FUNCTION get_polices_json RETURN CLOB;
    
    -- Insère ou met à jour une police à partir d'un flux JSON ultra-structuré (Endpoint POST/PUT ORDS)
    PROCEDURE save_police(p_json IN CLOB);
    
    -- Supprime discrètement une police par son ID technique (Endpoint DELETE ORDS)
    PROCEDURE delete_police(p_id IN NUMBER);
END pkg_polices;
/

CREATE OR REPLACE PACKAGE BODY orassadm.pkg_polices AS

    FUNCTION get_polices_json RETURN CLOB IS
        v_json CLOB;
    BEGIN
        -- Magie Oracle : Générer directement un JSON Web depuis le moteur SQL
        SELECT JSON_ARRAYAGG(
            JSON_OBJECT(
                'id' VALUE p.id,
                'numero_police' VALUE p.numero_police,
                'client_id' VALUE p.client_id,
                'client_nom' VALUE c.prenom || ' ' || c.nom,
                'vehicule' VALUE p.vehicule,
                'immatriculation' VALUE p.immatriculation,
                'formule' VALUE p.formule,
                'date_echeance' VALUE TO_CHAR(p.date_echeance, 'DD/MM/YYYY'),
                'prime_annuelle' VALUE p.prime_annuelle,
                'statut' VALUE p.statut
            ) RETURNING CLOB
        ) INTO v_json
        FROM orassadm.polices_auto p
        JOIN orassadm.clients c ON p.client_id = c.id;
        
        RETURN NVL(v_json, '[]');
    END get_polices_json;

    PROCEDURE save_police(p_json IN CLOB) IS
        v_id NUMBER;
        v_numero VARCHAR2(50);
        v_client_id NUMBER;
        v_vehicule VARCHAR2(150);
        v_immat VARCHAR2(20);
        v_formule VARCHAR2(100);
        v_date_str VARCHAR2(50);
        v_prime NUMBER;
        v_statut VARCHAR2(50);
    BEGIN
        -- Extraction des valeurs depuis le flux JSON web reçu via ORDS
        SELECT id, numero_police, client_id, vehicule, immatriculation, formule, date_echeance, prime_annuelle, statut
        INTO v_id, v_numero, v_client_id, v_vehicule, v_immat, v_formule, v_date_str, v_prime, v_statut
        FROM JSON_TABLE(p_json, '$'
            COLUMNS (
                id NUMBER PATH '$.id',
                numero_police VARCHAR2(50) PATH '$.numero_police',
                client_id NUMBER PATH '$.client_id',
                vehicule VARCHAR2(150) PATH '$.vehicule',
                immatriculation VARCHAR2(20) PATH '$.immatriculation',
                formule VARCHAR2(100) PATH '$.formule',
                date_echeance VARCHAR2(50) PATH '$.date_echeance', 
                prime_annuelle NUMBER PATH '$.prime_annuelle',
                statut VARCHAR2(50) PATH '$.statut'
            )
        );

        IF v_id IS NULL THEN
            INSERT INTO orassadm.polices_auto (numero_police, client_id, vehicule, immatriculation, formule, date_echeance, prime_annuelle, statut)
            VALUES (v_numero, v_client_id, v_vehicule, v_immat, v_formule, TO_DATE(v_date_str, 'YYYY-MM-DD'), v_prime, v_statut);
        ELSE
            UPDATE orassadm.polices_auto
            SET vehicule = v_vehicule,
                immatriculation = v_immat,
                formule = v_formule,
                date_echeance = TO_DATE(v_date_str, 'YYYY-MM-DD'),
                prime_annuelle = v_prime,
                statut = v_statut
            WHERE id = v_id;
        END IF;
    END save_police;

    PROCEDURE delete_police(p_id IN NUMBER) IS
    BEGIN
        DELETE FROM orassadm.polices_auto WHERE id = p_id;
    END delete_police;

END pkg_polices;
/
