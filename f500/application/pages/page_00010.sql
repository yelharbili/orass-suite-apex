prompt --application/pages/page_00010
begin
--   Manifest
--     PAGE: 00010
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.10.31'
,p_release=>'23.2.0'
,p_default_workspace_id=>3628745592366285
,p_default_application_id=>500
,p_default_id_offset=>0
,p_default_owner=>'ORASSADM'
);
wwv_flow_imp_page.create_page(
 p_id=>10
,p_name=>'Gestion Des Clients'
,p_alias=>'GESTION-DES-CLIENTS'
,p_step_title=>'Gestion Des Clients'
,p_autocomplete_on_off=>'OFF'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
''))
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// BREF: Quand on clique sur Nouveau (Il faut Vider les cases)',
'function openModal() {',
'    document.getElementById(''txtPrenom'').value = "";',
'    document.getElementById(''txtNom'').value = "";',
unistr('    apex.item("P10_CLIENT_ID").setValue(""); // Vider l''ID pour dire \00E0 Oracle = INSERT'),
'    document.getElementById(''clientModal'').classList.remove(''hidden'');',
'}',
'',
unistr('// BREF: Quand on clique sur Modification (Pr\00E9-remplir les cases)'),
'function editClient(id, prenom, nom) {',
'    document.getElementById(''txtPrenom'').value = prenom;',
'    document.getElementById(''txtNom'').value = nom;',
unistr('    apex.item("P10_CLIENT_ID").setValue(id); // M\00E9moriser l''ID cible pour dire \00E0 Oracle = UPDATE'),
'    document.getElementById(''clientModal'').classList.remove(''hidden'');',
'}',
'',
unistr('// BREF: G\00E9rer la Corbeille'),
'function deleteClient(id) {',
unistr('    // Demander confirmation gentiment au cas o\00F9 le clic serait une erreur'),
'    if(confirm("Confirmez-vous la suppression de ce client ?")) {',
'        apex.submit({',
'            request: "DELETE_CLIENT",',
'            set: { "P10_CLIENT_ID": id }',
'        });',
'    }',
'}',
'',
unistr('// BREF: Le Bouton d''Enregistrement qui s''adapte \00E0 la situation !'),
'function saveClient() {',
'    let champPrenom = document.getElementById(''txtPrenom'');',
'    let champNom = document.getElementById(''txtNom'');',
'',
'    if (!champPrenom || !champNom || champPrenom.value === "" || champNom.value === "") {',
unistr('        alert("Veuillez remplir le pr\00E9nom et le nom !");'),
'        return; ',
'    }',
'',
'    apex.submit({',
'        request: "SAVE_CLIENT", ',
'        set: {',
'            "P10_NEW_PRENOM": champPrenom.value,',
'            "P10_NEW_NOM": champNom.value,',
'            "P10_CLIENT_ID": apex.item("P10_CLIENT_ID").getValue() // Super important : On envoie l''ID !',
'        }',
'    });',
'}',
'',
'function closeModal() {',
'    document.getElementById(''clientModal'').classList.add(''hidden'');',
'}',
''))
,p_inline_css=>'#t_Header { display: none !important; }'
,p_step_template=>wwv_flow_imp.id(6066436818338918)
,p_page_template_options=>'#DEFAULT#:t-PageBody--noContentPadding'
,p_protection_level=>'C'
,p_page_component_map=>'03'
,p_last_updated_by=>'USERADMIN'
,p_last_upd_yyyymmddhh24miss=>'20260323172536'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(5743711882822511)
,p_plug_name=>'Design Principal'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(6078408357338928)
,p_plug_display_sequence=>10
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!-- SIDEBAR (Menu Fixe) -->',
'<aside class="w-64 bg-slate-900 text-slate-300 flex flex-col hidden md:flex border-r border-slate-800 fixed top-0 left-0 h-screen z-50">',
'    <div class="p-6 flex items-center gap-3 border-b border-slate-800">',
'        <div class="w-8 h-8 rounded-full border-4 border-amber-700 border-t-slate-500"></div>',
'        <span class="text-xl font-bold text-white tracking-wide">Orass-suite</span>',
'    </div>',
'    <nav class="flex-1 px-4 py-6 space-y-1">',
'        <a href="#" class="block px-4 py-2.5 hover:bg-slate-800 rounded-md transition text-sm font-medium">Tableau de bord</a>',
'        <a href="f?p=&APP_ID.:10:&APP_SESSION." class="block px-4 py-2.5 hover:bg-slate-800 rounded-md transition text-sm font-medium">Clients</a>',
'        <a href="#" class="block px-4 py-2.5 hover:bg-slate-800 rounded-md transition text-sm font-medium">Polices Auto</a>',
unistr('        <a href="#" class="block px-4 py-2.5 hover:bg-slate-800 rounded-md transition text-sm font-medium">Propri\00E9t\00E9</a>'),
unistr('        <a href="#" class="block px-4 py-2.5 hover:bg-slate-800 rounded-md transition text-sm font-medium">R\00E9clamations</a>'),
'    </nav>',
'</aside>',
'',
'<!-- HEADER (Fixe en haut) -->',
'<header class="ml-64 bg-white border-b border-slate-200 p-4 flex justify-between items-center px-8 fixed top-0 w-[calc(100%-16rem)] z-40">',
'    <h2 class="text-xl font-bold text-slate-800">Gestion Client Global</h2>',
'    <div class="flex items-center gap-6">',
'        <input type="text" placeholder="Rechercher..." class="px-4 py-2 bg-slate-100 border border-transparent rounded-md text-sm outline-none focus:bg-white focus:border-slate-300 transition w-64 hidden sm:block">',
'        <div class="flex items-center gap-3 border-l border-slate-200 pl-6">',
'            <span class="text-sm font-medium">Jean Dupont</span>',
'            <div class="w-9 h-9 bg-slate-300 rounded-full"></div>',
'        </div>',
'    </div>',
'</header>',
'',
'<!-- KPIs (Les petits blocs de chiffres) -->',
'<div class="ml-64 mt-20 p-8 pb-0">',
'    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">',
'        <div class="bg-white p-6 rounded-lg border border-slate-200 shadow-sm">',
'            <div class="flex justify-between items-start">',
'                <div>',
'                    <p class="text-sm text-slate-500 font-semibold mb-1">Total Clients</p>',
'                    <p class="text-3xl font-bold text-slate-900">&P10_TOTAL_CLIENTS.</p>',
'                </div>',
'                <span class="text-slate-400">&#128101;</span>',
'            </div>',
'        </div>',
'        <div class="bg-white p-6 rounded-lg border border-slate-200 shadow-sm border-t-4 border-t-slate-700">',
'            <div class="flex justify-between items-start">',
'                <div>',
'                    <p class="text-sm text-slate-500 font-semibold mb-1">Polices Actives</p>',
'                    <p class="text-3xl font-bold text-slate-900">338</p>',
'                </div>',
'                <span class="text-slate-400">&#128196;</span>',
'            </div>',
'        </div>',
'        <div class="bg-white p-6 rounded-lg border border-slate-200 shadow-sm border-t-4 border-t-amber-700">',
'            <div class="flex justify-between items-start">',
'                <div>',
'                    <p class="text-sm text-slate-500 font-semibold mb-1">Revenu Primes</p>',
unistr('                    <p class="text-3xl font-bold text-slate-900">15 020 k\20AC</p>'),
'                </div>',
'               <span class="text-amber-700">&#128182;</span>',
'            </div>',
'        </div>',
'    </div>',
'    ',
unistr('    <!-- FEN\00CATRE MODAL CACH\00C9E -->'),
'<div id="clientModal" class="fixed inset-0 bg-black/50 z-50 flex items-center justify-center p-4 transition-opacity duration-300 hidden">',
'    <div class="bg-white rounded-xl shadow-xl w-full max-w-xl border border-slate-200 overflow-hidden">',
'        <div class="flex items-center justify-between p-6 border-b border-slate-200 bg-slate-50">',
'            <h3 class="text-xl font-bold text-slate-800">Ajouter un Nouveau Client</h3>',
'            <button type="button" onclick="closeModal()" class="text-slate-400 hover:text-slate-600 transition px-2 py-1 rounded-full hover:bg-slate-200 font-bold text-xl">',
'                &times;',
'            </button>',
'        </div>',
'        <div class="p-6 space-y-4">',
'            <div class="grid grid-cols-2 gap-4">',
'                <div>',
unistr('                    <label class="block text-sm font-semibold text-slate-700 mb-1">Pr\00E9nom</label>'),
'                    <input id="txtPrenom" type="text" placeholder="Jean" class="w-full px-4 py-3 border border-slate-300 rounded-md bg-slate-50">',
'                </div>',
'                <div>',
'                    <label class="block text-sm font-semibold text-slate-700 mb-1">Nom</label>',
'                    <input id="txtNom" type="text" placeholder="Dupont" class="w-full px-4 py-3 border border-slate-300 rounded-md bg-slate-50">',
'                </div>',
'            </div>',
'        </div>',
'        <div class="flex items-center justify-end gap-3 p-6 border-t border-slate-200 bg-slate-50">',
'            <button type="button" onclick="closeModal()" class="px-5 py-2.5 border border-slate-300 rounded-md text-sm text-slate-700 font-semibold hover:bg-slate-100 transition">',
'                Annuler',
'            </button>',
'            <button type="button" onclick="saveClient()" class="px-5 py-2.5 bg-[#B85C00] text-white rounded-md text-sm font-semibold transition hover:bg-[#964B00] shadow-md">',
'                Enregistrer',
'            </button>',
'        </div>',
'    </div>',
'</div>',
'',
'</div>',
''))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(5744044932822514)
,p_name=>'Liste des Clients'
,p_template=>wwv_flow_imp.id(6145048272338954)
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'    id,',
'    prenom, ',
'    nom, ',
'    email, ',
'    total_polices,',
'    statut,',
'    CASE statut',
'        WHEN ''Active'' THEN ''bg-slate-700''',
'        WHEN ''Bronze'' THEN ''bg-amber-700''',
'        WHEN ''Suspended'' THEN ''bg-slate-500''',
'        ELSE ''bg-slate-700''',
'    END AS class_statut',
'FROM clients',
''))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>wwv_flow_imp.id(6352100525840150)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(5745329736822527)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>80
,p_column_heading=>'Id'
,p_use_as_row_header=>'N'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(5744125148822515)
,p_query_column_id=>2
,p_column_alias=>'PRENOM'
,p_column_display_sequence=>10
,p_column_heading=>'Prenom'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(5744282062822516)
,p_query_column_id=>3
,p_column_alias=>'NOM'
,p_column_display_sequence=>20
,p_column_heading=>'Nom'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(5744342024822517)
,p_query_column_id=>4
,p_column_alias=>'EMAIL'
,p_column_display_sequence=>30
,p_column_heading=>'Email'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(5744871435822522)
,p_query_column_id=>5
,p_column_alias=>'TOTAL_POLICES'
,p_column_display_sequence=>70
,p_column_heading=>'Total Polices'
,p_use_as_row_header=>'N'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(5744559998822519)
,p_query_column_id=>6
,p_column_alias=>'STATUT'
,p_column_display_sequence=>50
,p_column_heading=>'Statut'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(5744643918822520)
,p_query_column_id=>7
,p_column_alias=>'CLASS_STATUT'
,p_column_display_sequence=>60
,p_column_heading=>'Class Statut'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(5743855138822512)
,p_name=>'P10_TOTAL_CLIENTS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(5743711882822511)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(5744967510822523)
,p_name=>'P10_NEW_PRENOM'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(5743711882822511)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(5745006131822524)
,p_name=>'P10_NEW_NOM'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(5743711882822511)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(5745212001822526)
,p_name=>'P10_CLIENT_ID'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(5743711882822511)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(5745197342822525)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Inserer_Client_BDD'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P10_CLIENT_ID IS NULL THEN',
unistr('    -- Cas A : Aucun ID n''a \00E9t\00E9 m\00E9moris\00E9 (Nouveau Client)'),
'    INSERT INTO clients (prenom, nom, email, total_polices, statut)',
'         VALUES (',
'             :P10_NEW_PRENOM, ',
'             :P10_NEW_NOM, ',
'             LOWER(:P10_NEW_PRENOM || ''.'' || :P10_NEW_NOM || ''@example.com''), ',
'             1, ',
'             ''Active''',
'         );',
'ELSE',
unistr('    -- Cas B : Un ID a \00E9t\00E9 m\00E9moris\00E9 (On met \00E0 jour le client)'),
'    UPDATE clients ',
'       SET prenom = :P10_NEW_PRENOM, ',
'           nom    = :P10_NEW_NOM,',
'           email  = LOWER(:P10_NEW_PRENOM || ''.'' || :P10_NEW_NOM || ''@example.com'')',
'     WHERE id = :P10_CLIENT_ID;',
'END IF;',
''))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'SAVE_CLIENT'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
,p_internal_uid=>5745197342822525
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(5745477029822528)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Supprimer_Client_BDD'
,p_process_sql_clob=>'DELETE FROM clients WHERE id = :P10_CLIENT_ID;'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'DELETE_CLIENT'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
,p_internal_uid=>5745477029822528
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(5743949416822513)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Calculer_Clients'
,p_process_sql_clob=>'SELECT COUNT(*) INTO :P10_TOTAL_CLIENTS FROM clients;'
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>5743949416822513
);
wwv_flow_imp.component_end;
end;
/
