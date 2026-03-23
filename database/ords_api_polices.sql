BEGIN
  -- Paramétrage global pour activer REST sur le Schéma ORASSADM (Si ce n'est pas déjà fait)
  ORDS.ENABLE_SCHEMA(
      p_enabled             => TRUE,
      p_schema              => 'ORASSADM',
      p_url_mapping_type    => 'BASE_PATH',
      p_url_mapping_pattern => 'orassadmin',
      p_auto_rest_auth      => FALSE
  );

  -- 1. Création du Module Principal (Le dossier Web)
  ORDS.DEFINE_MODULE(
      p_module_name    => 'api_orass',
      p_base_path      => '/api_orass/v1/',
      p_items_per_page => 25,
      p_status         => 'PUBLISHED',
      p_comments       => 'Module principal pour les Web Services Orass-Suite'
  );

  -- 2. DÉCLARATION POUR LA LECTURE MULTIPLE ET L'INSERTION (Route de base)
  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'api_orass',
      p_pattern        => 'polices/',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL 
  );

  -- Handler GET : Renvoie le JSON compilé par le Package Oracle
  ORDS.DEFINE_HANDLER(
      p_module_name    => 'api_orass',
      p_pattern        => 'polices/',
      p_method         => 'GET',
      p_source_type    => 'plsql/block',
      p_items_per_page => 25,
      p_mimes_allowed  => '',
      p_comments       => 'Lecture de toutes les polices au format JSON pur',
      p_source         => 'BEGIN
                             -- On règle le Header HTTP de réponse pour dire au navigateur "C est du JSON"
                             OWA_UTIL.MIME_HEADER(''application/json'', TRUE, ''UTF-8'');
                             -- HTP.P imprime littéralement le contenu JSON calculé par le Package BDD
                             HTP.P(orassadm.pkg_polices.get_polices_json);
                           END;'
  );

  -- Handler POST : Pour L'update ou l'Insert (Selon si un ID est présent dans le JSON d'envoi)
  ORDS.DEFINE_HANDLER(
      p_module_name    => 'api_orass',
      p_pattern        => 'polices/',
      p_method         => 'POST',
      p_source_type    => 'plsql/block',
      p_items_per_page => 25,
      p_mimes_allowed  => 'application/json',
      p_comments       => 'Save ou Update via flux JS',
      p_source         => 'BEGIN
                             -- ORDS peuple magiquement la variable ":body_text" avec le JSON venant de Fetch()
                             orassadm.pkg_polices.save_police(p_json => :body_text);
                             :status_code := 201; -- 201 Created/Updated
                           END;'
  );

  -- 3. DÉCLARATION DU ROUTEUR POUR SUPPRIMER (Passage d'un ID en fin d'URL)
  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'api_orass',
      p_pattern        => 'polices/:id',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL 
  );

  -- Handler DELETE : Récupération de l'ID via l'URL (:id)
  ORDS.DEFINE_HANDLER(
      p_module_name    => 'api_orass',
      p_pattern        => 'polices/:id',
      p_method         => 'DELETE',
      p_source_type    => 'plsql/block',
      p_items_per_page => 25,
      p_mimes_allowed  => '',
      p_comments       => 'Suppression d une police auto précise',
      p_source         => 'BEGIN
                             -- La variable ":id" prend la valeur du ":id" de l"URL !
                             orassadm.pkg_polices.delete_police(p_id => :id);
                             :status_code := 204; -- 204 No Content (Deleted)
                           END;'
  );

  COMMIT;
END;
/
