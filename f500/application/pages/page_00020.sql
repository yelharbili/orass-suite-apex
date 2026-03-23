prompt --application/pages/page_00020
begin
--   Manifest
--     PAGE: 00020
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
 p_id=>20
,p_name=>'Polices Auto'
,p_alias=>'POLICES-AUTO'
,p_step_title=>'Polices Auto'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('// URL secr\00E8te de notre API REST (Ajustez si besoin selon l''URL de votre APEX)'),
'const API_URL = "http://192.168.108.149:8181/ords/orassuitpdb/orassadmin/api_orass/v1/polices/";',
'',
'// 1. Bouton NOUVEAU',
'// 1. Bouton NOUVEAU',
'function openModalPolice() {',
'    document.getElementById(''modalTitle'').innerText = "Nouvelle Police";',
'    document.getElementById(''txtId'').value = ""; // ID Vide = Le package Oracle fera un SQL INSERT',
unistr('    document.getElementById(''txtNumPolice'').value = "AX-" + Math.floor(Math.random() * 900000); // Autog\00E9n\00E9raction du N\00B0'),
'    ',
'   ',
'',
'    // Optionnel : on vide les autres cases pour que ce soit propre',
'    document.getElementById(''txtVehicule'').value = "";',
'    document.getElementById(''txtImmat'').value = "";',
'',
'    const m = document.getElementById(''modalPolice'');',
'    m.classList.remove(''hidden'');',
'    m.classList.add(''flex''); // Affiche la Modale',
'}',
'',
'',
unistr('// 2. Bouton CRAYON (Pr\00E9-chargement des donn\00E9es de la liste APEX dans la boite)'),
'function editPolice(id, num, client_id, vehicule, immat, formule, date_ech, prime, statut) {',
'    document.getElementById(''modalTitle'').innerText = "Modifier la Police";',
unistr('    document.getElementById(''txtId'').value = id; // ID Pr\00E9sent = Le package Oracle fera un SQL UPDATE'),
'    document.getElementById(''txtNumPolice'').value = num;',
'    document.getElementById(''txtClientId'').value = client_id;',
'    document.getElementById(''txtVehicule'').value = vehicule;',
'    document.getElementById(''txtImmat'').value = immat;',
'    document.getElementById(''txtFormule'').value = formule;',
'    document.getElementById(''txtPrime'').value = prime;',
'    document.getElementById(''txtStatut'').value = statut;',
'',
'    // Magie noire APEX vs JS: APEX renvoie la date en JJ/MM/AAAA, le calendrier HTML exige AAAA-MM-JJ !',
'    if(date_ech && date_ech.includes(''/'')) {',
'        let parts = date_ech.split(''/''); ',
'        document.getElementById(''txtDate'').value = parts[2] + ''-'' + parts[1] + ''-'' + parts[0];',
'    }',
'',
'    const m = document.getElementById(''modalPolice'');',
'    m.classList.remove(''hidden'');',
'    m.classList.add(''flex'');',
'}',
'',
'// 3. Fermeture douce de la modale',
'function closeModalPolice() {',
'    const m = document.getElementById(''modalPolice'');',
'    m.classList.add(''hidden'');',
'    m.classList.remove(''flex'');',
'}',
'',
'// 4. L''Appel Magique RESTful au clic de ''Enregistrer'' !',
unistr('// Le navigateur envoie de mani\00E8re invisible un Payload JSON au package SQL Oracle'),
'function savePolice() {',
'    const payload = {',
'        id: document.getElementById(''txtId'').value ? parseInt(document.getElementById(''txtId'').value) : null,',
'        numero_police: document.getElementById(''txtNumPolice'').value,',
'        client_id: parseInt(document.getElementById(''txtClientId'').value),',
'        vehicule: document.getElementById(''txtVehicule'').value,',
'        immatriculation: document.getElementById(''txtImmat'').value,',
'        formule: document.getElementById(''txtFormule'').value,',
unistr('        date_echeance: document.getElementById(''txtDate'').value, // Renvoi standardis\00E9 YYYY-MM-DD'),
'        prime_annuelle: parseFloat(document.getElementById(''txtPrime'').value),',
'        statut: document.getElementById(''txtStatut'').value',
'    };',
'',
'    // La Frappe Silencieuse du Fetch (Protocole HTTP POST - Sans recharger APEX)',
'    fetch(API_URL, {',
'        method: ''POST'',',
'        headers: { ''Content-Type'': ''application/json'' },',
'        body: JSON.stringify(payload)',
'    })',
'    .then(response => {',
'        if(response.ok) {',
'            closeModalPolice();',
unistr('            location.reload(); // Rafra\00EEchit l''\00E9cran complet une fois les donn\00E9es stock\00E9es'),
'        } else {',
unistr('            alert("Erreur de l''API (Check Console). V\00E9rifiez vos cl\00E9s et r\00E9f\00E9rences !");'),
'        }',
'    })',
'    .catch(err => alert("Erreur Internet Client : " + err));',
'}',
'',
'// 5. La Suppression Furtive (HTTP DELETE)',
'function deletePolice(id) {',
unistr('    if(confirm("D\00E9truire d\00E9finitivement ce contrat d''assurance ?")) {'),
'        fetch(API_URL + id, { method: ''DELETE'' })',
'        .then(res => {',
'            if(res.ok) location.reload();',
'        });',
'    }',
'}',
'',
'',
'// Adresse locale de votre Web Service des clients',
'const API_CLIENTS = "http://192.168.108.149:8181/ords/orassuitpdb/orassadmin/api_orass/v1/clients/";',
'',
unistr('// M\00E9canisme Web Asynchrone : Se d\00E9clenche quand Chrome a fini de charger le Tailwind'),
'document.addEventListener("DOMContentLoaded", function() {',
'    ',
'    // Appel du service ORDS (Sans aucun raffraichissement de page APEX !)',
'    fetch(API_CLIENTS)',
'    .then(response => response.json())',
'    .then(clients => {',
'        const select = document.getElementById("txtClientId");',
'        ',
'        // On nettoie la case "-- Chargement... --"',
'        select.innerHTML = ""; ',
'        ',
'        // On boucle sur l''ensemble de notre JSON Oracle !',
'        clients.forEach(c => {',
'            let option = document.createElement("option");',
'            option.value = c.id; ',
unistr('            option.text = c.prenom + " " + c.nom + " (Dossier N\00B0" + c.id + ")";'),
'            select.appendChild(option); // L''option pop dans la liste visuelle !',
'        });',
'    })',
unistr('    .catch(err => console.error("Le Serveur n''a pas r\00E9pondu pour les clients:", err));'),
'',
'',
unistr('        // === CALCUL DES KPIs EN TEMPS R\00C9EL (Big Data Client) ==='),
'    fetch("http://192.168.108.149:8181/ords/orassuitpdb/orassadmin/api_orass/v1/polices/")',
'    .then(r => r.json())',
'    .then(polices => {',
unistr('        // 1. Compter toutes les polices remont\00E9es depuis le serveur d''assurance Oracle'),
'        let nbTotal = polices.length;',
'        document.getElementById(''kpiActives'').innerText = nbTotal;',
'        ',
'        // 2. Additionner le Chiffre d''Affaires avec Reduce JS (Somme exacte des colonnes "prime_annuelle")',
'        let totalCA = polices.reduce((somme, pol) => somme + (pol.prime_annuelle || 0), 0);',
'        // On formate visuellement "12503" en "12 503,00" selon la syntaxe FR W3C',
'        document.getElementById(''kpiPrimes'').innerText = new Intl.NumberFormat(''fr-FR'').format(totalCA);',
'        ',
unistr('        // 3. Isoler le lot exact de contrats o\00F9 le statut indique "Renouvellement" !'),
'        let nbRenouvellement = polices.filter(pol => (pol.statut || "").toLowerCase().includes("renouvellement")).length;',
'        document.getElementById(''kpiRenouv'').innerText = nbRenouvellement;',
'    })',
'    .catch(err => console.error("Le processeur de Statistiques est en anomalie :", err));',
'',
'});',
'',
unistr('// === La m\00E9moire de l''\00E9cran APEX Actuel ==='),
'let curPolicyId = null;',
'let curClientId = null;',
'',
unistr('// Ouverture de la modale D\00E9taill\00E9e (Maintenant on stocke secr\00E8tement l''Id et le Client Id !)'),
'function showDetailPolice(id, clientId, num, client, vehicule, immat, formule, date_ech, prime, statut) {',
'    curPolicyId = parseInt(id); // Conservation dans la RAM',
'    curClientId = parseInt(clientId);',
'    ',
'    document.getElementById(''detNum'').innerText = num;',
'    document.getElementById(''detTitle'').innerText = client + " - " + vehicule;',
unistr('    document.getElementById(''detSubtitle'').innerText = "N\00B0 de Police Contractuelle : " + num;'),
unistr('    document.getElementById(''detPrime'').innerText = prime + " \20AC";'),
'    document.getElementById(''detFormule'').innerText = formule;',
'    document.getElementById(''detDate'').innerText = date_ech;',
'    document.getElementById(''detImmat'').innerText = immat;',
'    document.getElementById(''detVehicule'').innerText = vehicule;',
'    document.getElementById(''detStatut'').innerText = statut;',
'',
'    const m = document.getElementById(''detailModalPolicy'');',
'    m.classList.remove(''hidden'');',
'    m.classList.add(''flex'');',
'}',
'',
'// === L''Animation Renouvellement + FIX BUG DE DATE ===',
'function toggleRenewMode() {',
'    const aiBlock = document.getElementById(''blocAiInsights'');',
'    const renewBlock = document.getElementById(''blocRenouvellement'');',
'    ',
'    if(aiBlock.classList.contains(''hidden'')) {',
'        aiBlock.classList.remove(''hidden'');',
'        renewBlock.classList.add(''hidden'');',
'    } else {',
'        aiBlock.classList.add(''hidden'');',
'        renewBlock.classList.remove(''hidden'');',
'        ',
unistr('        // Ex: "22/09/2026" renvoy\00E9 par Oracle APEX'),
'        let oldStr = document.getElementById(''detDate'').innerText; ',
'        document.getElementById(''renewOldDate'').innerText = oldStr; ',
'        ',
'        // CORRECTION DU CALENDRIER ! Conversion DD/MM/YYYY vers Moteur Chromium YYYY-MM-DD',
'        if(oldStr && oldStr.includes(''/'')) {',
'            let parts = oldStr.split(''/''); // Isole le tiret ["22", "09", "2026"]',
'            let oldYear = parseInt(parts[2]); // On extrait 2026',
unistr('            // On calcule pr\00E9cis\00E9ment la date dans 1 an (2027-09-22)'),
'            let newDateStr = (oldYear + 1) + "-" + parts[1] + "-" + parts[0]; ',
unistr('            document.getElementById(''renewNewDate'').value = newDateStr; // Le Calendrier est par\00E9 et pr\00EAt \00E0 \00EAtre d\00E9cal\00E9 de nouveau !'),
'        }',
'    }',
'}',
'',
unistr('// === La V\00E9ritable Op\00E9ration BDD "CONFIRMER = UPDATE" ==='),
'function confirmRenewal() {',
unistr('    // 1. Confectionne le bordereau JSON de Renouvellement (Met \00E0 jour la Date, la Prime et le Statut en Active-Renouvel\00E9e)'),
'    const payload = {',
unistr('        id: curPolicyId,  // Pr\00E9sence d''ID = Le package fera un UPDATE ! \00BF'),
'        numero_police: document.getElementById(''detNum'').innerText,',
'        client_id: curClientId,',
'        vehicule: document.getElementById(''detVehicule'').innerText,',
'        immatriculation: document.getElementById(''detImmat'').innerText,',
'        formule: document.getElementById(''detFormule'').innerText,',
unistr('        date_echeance: document.getElementById(''renewNewDate'').value, // Transmet la date W3C choisie via le s\00E9lecteur'),
'        prime_annuelle: parseFloat(document.getElementById(''txtNewPrime'').value),',
'        statut: "Renouvellement"',
'    };',
'',
unistr('    // 2. Frappe Chirurgicale R\00E9seau (Fetch APEX asynchrone)'),
'    fetch("http://192.168.108.149:8181/ords/orassuitpdb/orassadmin/api_orass/v1/polices/", {',
unistr('        method: ''POST'', // Notre interface commune pour Cr\00E9er et Modifier'),
'        headers: { ''Content-Type'': ''application/json'' },',
'        body: JSON.stringify(payload)',
'    })',
'    .then(r => {',
'        if(r.ok) {',
'            closeDetailModal();',
unistr('            location.reload(); // Triomphalement, la page APEX ressuscite l''\00E9cran global pour afficher la date repouss\00E9e d''un An !'),
'        } else {',
unistr('            alert("Erreur de Transmission S\00E9curis\00E9e vers ORDS Oracle.");'),
'        }',
'    });',
'}',
'',
'',
unistr('// Fonction pour fermer la fen\00EAtre en cliquant sur la petite croix (X)'),
'function closeDetailModal() {',
'    const m = document.getElementById(''detailModalPolicy'');',
'    m.classList.add(''hidden'');',
'    m.classList.remove(''flex'');',
'}',
'',
'',
'',
''))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#t_Header, #t_Body_nav, .t-Body-title { display: none !important; }',
'.t-Body-main { margin-top: 0 !important; padding: 0 !important; }',
''))
,p_step_template=>wwv_flow_imp.id(6066436818338918)
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'03'
,p_last_updated_by=>'USERADMIN'
,p_last_upd_yyyymmddhh24miss=>'20260323225448'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(5746893507822542)
,p_name=>'Tableau API ORDS'
,p_template=>wwv_flow_imp.id(6078408357338928)
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_location=>'WEB_SOURCE'
,p_web_src_module_id=>wwv_flow_imp.id(6405636906453300)
,p_header=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<script src="https://cdn.tailwindcss.com"></script>',
'',
unistr('<!-- MENU LAT\00C9RAL (Fix\00E9 \00E0 gauche) -->'),
'<aside class="w-64 bg-slate-900 text-slate-300 hidden md:flex flex-col border-r border-slate-800 fixed top-0 left-0 h-screen z-50">',
'    <div class="p-6 flex items-center gap-3 border-b border-slate-800">',
'        <div class="w-8 h-8 rounded-full border-4 border-amber-700 border-t-slate-500"></div>',
'        <span class="text-xl font-bold text-white tracking-wide">Orass-suite</span>',
'    </div>',
'    <nav class="flex-1 px-4 py-6 space-y-1">',
'        <a href="f?p=&APP_ID.:10:&APP_SESSION." class="block px-4 py-2.5 hover:bg-slate-800 rounded-md transition text-sm font-medium">Clients</a>',
'        <a href="f?p=&APP_ID.:20:&APP_SESSION." class="block px-4 py-2.5 bg-slate-800 text-white rounded-md border-l-4 border-amber-700 shadow-sm text-sm font-medium">Polices Auto</a>',
'    </nav>',
'</aside>',
'',
unistr('<!-- CONTENEUR GLOBAL D\00C9CAL\00C9 (ml-64 repousse tout le reste \00E0 256px de la gauche) -->'),
'<div class="md:ml-64 bg-slate-50 min-h-screen flex flex-col font-sans text-slate-800 relative">',
'    ',
unistr('    <!-- HEADER HAUT (Fix\00E9 en haut, mais qui commence apr\00E8s la marge de 64 ! Hauteur forc\00E9e \00E0 72px) -->'),
'    <header class="bg-white border-b border-slate-200 p-4 flex justify-between items-center px-8 fixed top-0 right-0 left-0 md:left-64 z-40 h-[72px]">',
'        <h2 class="text-xl font-bold text-slate-800">Gestion Police Global</h2>',
'        <div class="flex items-center gap-6">',
'            <input type="text" placeholder="Rechercher..." class="px-4 py-2 bg-slate-100 border border-transparent rounded-md text-sm outline-none focus:bg-white focus:border-slate-300 transition w-64 hidden sm:block">',
'            <div class="flex items-center gap-3 border-l border-slate-200 pl-6">',
unistr('                <span class="text-sm font-medium">Connect\00E9 : DEV 2</span>'),
'                <div class="w-9 h-9 bg-slate-300 rounded-full"></div>',
'            </div>',
'        </div>',
'    </header>',
'',
unistr('    <!-- ESPACE CENTRAL DU TABLEAU (Ici on place un Margin-Top mt-[72px] pour ne pas \00EAtre englouti sous le header !) -->'),
'    <main class="flex-1 p-8 mt-[72px]">',
'        ',
'        <!-- BLOC DES 3 KPIs -->',
'               <!-- BLOC DES 3 KPIs DYNAMIQUES -->',
'        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">',
'            <div class="bg-white p-6 rounded-lg shadow-sm border border-slate-200 border-t-4 border-t-slate-500">',
'                <p class="text-sm text-slate-500 font-semibold mb-1">Volume de Polices</p>',
'                <!-- Balise vide avec un ID -->',
'                <p class="text-3xl font-bold text-slate-900"><span id="kpiActives" class="text-slate-900">...</span> &#128663;</p>',
'            </div>',
'            <div class="bg-white p-6 rounded-lg shadow-sm border border-slate-200 border-t-4 border-t-slate-700">',
'                <p class="text-sm text-slate-500 font-semibold mb-1">Chiffre d''Affaires Global</p>',
'                <!-- On ajoute l''id kpiPrimes -->',
unistr('                <p class="text-3xl font-bold text-slate-900"><span id="kpiPrimes">...</span> \20AC &#128182;</p>'),
'            </div>',
'            <div class="bg-amber-50 p-6 rounded-lg shadow-sm border border-amber-200 border-t-4 border-t-amber-700">',
'                <p class="text-sm text-amber-800 font-semibold mb-1">Statuts "Renouvellement"</p>',
'                <!-- On ajoute l''id kpiRenouv -->',
'                <p class="text-3xl font-bold text-amber-900"><span id="kpiRenouv">...</span> &#9888;</p>',
'            </div>',
'        </div>',
'',
'<!-- LE TABLEAU DYNAMIQUE D''APEX S''INJECTERA AUTOMATIQUEMENT ICI -->',
''))
,p_footer=>wwv_flow_string.join(wwv_flow_t_varchar2(
'    </main>',
'</div>',
''))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>wwv_flow_imp.id(6406471597498256)
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
 p_id=>wwv_flow_imp.id(5746954913822543)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_column_heading=>'Id'
,p_use_as_row_header=>'N'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(5747060951822544)
,p_query_column_id=>2
,p_column_alias=>'STATUT'
,p_column_display_sequence=>20
,p_column_heading=>'Statut'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(5747130856822545)
,p_query_column_id=>3
,p_column_alias=>'FORMULE'
,p_column_display_sequence=>30
,p_column_heading=>'Formule'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(5747260433822546)
,p_query_column_id=>4
,p_column_alias=>'VEHICULE'
,p_column_display_sequence=>40
,p_column_heading=>'Vehicule'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(5747363036822547)
,p_query_column_id=>5
,p_column_alias=>'CLIENT_ID'
,p_column_display_sequence=>50
,p_column_heading=>'Client Id'
,p_use_as_row_header=>'N'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(5747416586822548)
,p_query_column_id=>6
,p_column_alias=>'CLIENT_NOM'
,p_column_display_sequence=>60
,p_column_heading=>'Client Nom'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(5747548826822549)
,p_query_column_id=>7
,p_column_alias=>'DATE_ECHEANCE'
,p_column_display_sequence=>70
,p_column_heading=>'Date Echeance'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(5747614716822550)
,p_query_column_id=>8
,p_column_alias=>'NUMERO_POLICE'
,p_column_display_sequence=>80
,p_column_heading=>'Numero Police'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(6413818651715601)
,p_query_column_id=>9
,p_column_alias=>'PRIME_ANNUELLE'
,p_column_display_sequence=>90
,p_column_heading=>'Prime Annuelle'
,p_use_as_row_header=>'N'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(6413921619715602)
,p_query_column_id=>10
,p_column_alias=>'IMMATRICULATION'
,p_column_display_sequence=>100
,p_column_heading=>'Immatriculation'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(6414004839715603)
,p_plug_name=>unistr('Fen\00EAtre Modale \00C9dition')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(6078408357338928)
,p_plug_display_sequence=>20
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!-- FOND D''ASSOMBRISSEMENT INVISIBLE PAR DEFAUT -->',
'<div id="modalPolice" class="fixed inset-0 bg-slate-900/50 backdrop-blur-sm hidden items-center justify-center z-50">',
'    ',
unistr('    <!-- LA FEN\00CATRE BLANCHE TIRE DE L''IMAGE -->'),
'    <div class="bg-white rounded-lg shadow-xl w-full max-w-md mx-4 overflow-hidden border border-slate-200">',
'        ',
'        <!-- HEADER EXACT -->',
'        <div class="p-4 border-b border-slate-100 flex justify-between items-center">',
'            <h3 class="text-lg font-bold text-slate-800 flex items-center gap-2">',
'                <span class="text-amber-600">&#9998;</span> <span id="modalTitle">Modifier la Police</span>',
'            </h3>',
'            <button type="button" onclick="closeModalPolice()" class="text-slate-400 hover:text-slate-600 transition text-2xl font-light">&times;</button>',
'        </div>',
'',
'        <!-- CORPS DU FORMULAIRE -->',
'        <div class="p-6 space-y-4">',
'            ',
unistr('            <!-- CACH\00C9 OU TECHNIQUE -->'),
'            <input type="hidden" id="txtId">',
'            <input type="hidden" id="txtStatut" value="Active">',
'',
'            <div class="grid grid-cols-2 gap-4">',
'                <div>',
unistr('                    <label class="block text-xs font-bold text-slate-600 mb-1">N\00B0 Police Autog\00E9n\00E9r\00E9e</label>'),
'                    <input type="text" id="txtNumPolice" placeholder="AX-999..." class="w-full border border-slate-300 rounded-md px-3 py-2 text-sm outline-none focus:border-slate-800">',
'                </div>',
'                                <div>',
unistr('                    <label class="block text-xs font-bold text-slate-600 mb-1">Client Associ\00E9</label>'),
'                    <select id="txtClientId" class="w-full border border-slate-300 rounded-md px-3 py-2 text-sm text-slate-800 bg-white outline-none focus:border-slate-800 focus:ring-1 focus:ring-slate-800">',
'                        <option value="">-- Chargement des clients... --</option>',
'                    </select>',
'                </div>',
'',
'            </div>',
'            ',
'            <div class="grid grid-cols-2 gap-4 mb-4">',
'                <div>',
unistr('                    <label class="block text-xs font-bold text-slate-600 mb-1">V\00E9hicule</label>'),
'                    <input type="text" id="txtVehicule" class="w-full border border-slate-300 rounded-md px-3 py-2 text-sm outline-none focus:border-slate-800">',
'                </div>',
'                <div>',
'                    <label class="block text-xs font-bold text-slate-600 mb-1">Immat.</label>',
'                    <input type="text" id="txtImmat" class="w-full border border-slate-300 rounded-md px-3 py-2 text-sm outline-none focus:border-slate-800">',
'                </div>',
'            </div>',
'',
unistr('            <!-- FID\00C9LIT\00C9 \00C0 100% AVEC L''IMAGE -->'),
'            <div>',
'                <label class="block text-sm font-bold text-slate-700 mb-1">Type de Couverture</label>',
'                <select id="txtFormule" class="w-full border border-slate-300 rounded-md px-3 py-2 text-sm text-slate-800 bg-white focus:border-slate-800 focus:ring-1 focus:ring-slate-800 outline-none">',
'                    <option>Tous Risques</option>',
unistr('                    <option>Tiers \00C9tendu</option>'),
'                    <option>Au Tiers</option>',
'                </select>',
'            </div>',
'',
'            <div class="grid grid-cols-2 gap-4">',
'                <div>',
unistr('                    <label class="block text-sm font-bold text-slate-700 mb-1">Prime Annuelle (\20AC)</label>'),
'                    <input type="number" step="0.01" id="txtPrime" value="1805.75" class="w-full border-2 border-slate-800 rounded-md px-3 py-2 text-sm font-medium text-slate-900 outline-none">',
'                </div>',
'                <div>',
unistr('                    <label class="block text-sm font-bold text-slate-700 mb-1">Date d''\00E9ch\00E9ance</label>'),
'                    <input type="date" id="txtDate" value="2026-09-22" class="w-full border border-slate-300 rounded-md px-3 py-2 text-sm text-slate-800 focus:border-slate-800 outline-none">',
'                </div>',
'            </div>',
'',
'            <div>',
'                <label class="block text-sm font-bold text-slate-700 mb-1 mt-2">Notes internes</label>',
'                <textarea id="txtNotes" rows="3" placeholder="Raison de la modification..." class="w-full border border-slate-300 rounded-md px-3 py-2 text-sm text-slate-600 focus:border-slate-800 outline-none resize-none"></textarea>',
'            </div>',
'        </div>',
'',
unistr('        <!-- PIED DE LA FEN\00CATRE (Boutons identiques) -->'),
'        <div class="p-4 bg-slate-50 flex justify-end gap-3 mt-2">',
'            <button type="button" onclick="closeModalPolice()" class="px-5 py-2 border border-slate-300 text-slate-700 bg-white rounded-md text-sm font-bold hover:bg-slate-100 transition">Annuler</button>',
'            <button type="button" onclick="savePolice()" class="px-5 py-2 bg-slate-900 text-white rounded-md text-sm font-bold hover:bg-slate-800 transition shadow-sm">Enregistrer les modifs</button>',
'        </div>',
'',
'    </div>',
'</div>',
''))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(6414181728715604)
,p_plug_name=>'Modale Consultation'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(6078408357338928)
,p_plug_display_sequence=>30
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!-- FOND NOIR MODALE DETAILS -->',
'<div id="detailModalPolicy" class="fixed inset-0 bg-slate-900/60 backdrop-blur-sm hidden items-center justify-center z-[100] p-4">',
'    <!-- CADRE GEANT -->',
'    <div class="bg-slate-50 w-full max-w-5xl rounded-xl shadow-2xl border border-slate-200 overflow-hidden flex flex-col max-h-[90vh]">',
'        ',
'        <!-- HEADER -->',
'        <div class="bg-white px-8 py-4 border-b border-slate-200 flex justify-between items-center shrink-0">',
unistr('            <h2 class="text-xl font-bold text-slate-800">D\00E9tails de la Police : <span id="detNum" class="text-amber-700"></span></h2>'),
'            <button type="button" onclick="closeDetailModal()" class="text-slate-400 hover:text-red-600 transition text-3xl font-light">&times;</button>',
'        </div>',
'        ',
unistr('        <!-- CORPS DEFILEUR (Adapt\00E9 de votre maquette) -->'),
'        <div class="p-8 overflow-y-auto">',
'            <div class="flex justify-between items-end mb-6">',
'                <div>',
'                    <h1 class="text-4xl font-bold text-slate-900 tracking-tight" id="detTitle">Jean Dupont, Clio 5</h1>',
unistr('                    <p class="text-slate-500 font-medium mt-1 text-lg mb-2" id="detSubtitle">Police N\00B0 AX-290034</p>'),
'                </div>',
'            </div>',
'',
'            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">',
'                <div class="flex flex-col gap-6">',
'                    <div class="bg-white p-6 rounded-lg border border-slate-200 shadow-sm">',
'                        <h3 class="font-bold text-slate-800 mb-4 border-b pb-2">Informations de Base</h3>',
'                        <div class="grid grid-cols-2 gap-4">',
'                            <div>',
'                                <p class="text-xs text-slate-500 uppercase tracking-wide">Prime Annuelle</p>',
unistr('                                <p class="text-xl font-bold text-amber-700" id="detPrime">1 805,75 \20AC</p>'),
'                            </div>',
'                            <div>',
'                                <p class="text-xs text-slate-500 uppercase tracking-wide">Couverture</p>',
'                                <p class="text-lg font-bold text-slate-700" id="detFormule">Tous Risques</p>',
'                            </div>',
'                            <div class="col-span-2 mt-2">',
unistr('                                <p class="text-xs text-slate-500 uppercase tracking-wide mb-1">Date d''\00E9ch\00E9ance</p>'),
'                                <p class="font-semibold text-slate-800 text-lg" id="detDate">22/09/2026</p>',
'                            </div>',
'                            <div class="col-span-2">',
'                                <p class="text-xs text-slate-500 uppercase tracking-wide mb-2">Statut Actuel</p>',
'                                <span class="bg-slate-700 text-white px-3 py-1 rounded-sm text-xs font-semibold tracking-wide" id="detStatut">Active</span>',
'                            </div>',
'                        </div>',
'                    </div>',
'                </div>',
'',
'                <div class="lg:col-span-2 flex flex-col gap-6">',
'                    <div class="bg-slate-900 p-6 rounded-lg shadow-md text-white border border-slate-800">',
'                        <div class="flex justify-between items-start mb-4">',
unistr('                            <h3 class="font-bold text-lg text-slate-200">V\00E9hicule Assur\00E9</h3>'),
'                            <span class="bg-amber-700 text-sm px-3 py-1 rounded font-bold tracking-wider" id="detImmat">FR-2023-CD</span>',
'                        </div>',
'                        <div class="flex items-center gap-6">',
'                            <div class="w-1/3 h-32 bg-slate-800 rounded-md border border-slate-700 flex items-center justify-center text-slate-400 text-6xl shadow-inner">',
'                                &#128663;',
'                            </div>',
'                            <div class="w-2/3 space-y-4">',
'                                <div>',
unistr('                                    <p class="text-xs text-slate-400 uppercase tracking-wide">Mod\00E8le</p>'),
'                                    <p class="text-2xl font-bold text-white tracking-wide" id="detVehicule">Renault Clio 5</p>',
'                                </div>',
'                            </div>',
'                        </div>',
'                    </div>',
'',
'<!-- === DUAL BLOCK : AI ou RENOUVELLEMENT === -->',
'<div class="relative overflow-hidden rounded-lg border border-amber-200 shadow-sm bg-gradient-to-br from-white to-amber-50">',
'    ',
'    <!-- FACE 1 : BLOC AI INSIGHTS -->',
'    <div id="blocAiInsights" class="p-6 transition-all duration-300">',
'        <div class="flex justify-between items-start mb-4">',
'           ',
unistr('            <!-- CORRIG\00C9 : type="button" emp\00EAche un plantage ! L''ic\00F4ne est dessin\00E9e en SVG HD -->'),
'            <button type="button" onclick="toggleRenewMode()" class="border border-amber-700 text-amber-800 bg-white hover:bg-amber-100 px-3 py-1.5 rounded text-xs font-bold flex items-center gap-1.5 transition shadow-sm">',
'                <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.00'
||'3 0 01-15.357-2m15.357 2H15"></path></svg> ',
'                Renouveler',
'            </button>',
'        </div>',
'    ',
'    </div>',
'',
'    <!-- FACE 2 : BLOC RENOUVELLEMENT -->',
'    <div id="blocRenouvellement" class="p-6 hidden transition-all duration-300">',
'        <div class="flex justify-between items-start mb-4">',
'            <h3 class="font-bold text-amber-900 flex items-center gap-2 text-lg">',
'                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01'
||'-15.357-2m15.357 2H15"></path></svg> ',
'                Renouveler la Police',
'            </h3>',
unistr('            <!-- CORRIG\00C9 : type="button" emp\00EAche le Submit lors de l''Annulation -->'),
'            <button type="button" type="button" onclick="toggleRenewMode()" class="text-amber-700 hover:text-amber-900 text-2xl font-bold transition" title="Annuler">&times;</button>',
'        </div>',
'        ',
'           <div class="bg-slate-100 p-4 rounded-md border border-slate-200 flex justify-between items-center mb-4 mt-2">',
'            <div>',
unistr('                <p class="text-[11px] text-slate-500 uppercase font-bold tracking-wide">\00C9ch\00E9ance Actuelle</p>'),
'                <p class="text-lg font-bold text-slate-800" id="renewOldDate">22/09/2026</p>',
'            </div>',
'            ',
unistr('            <!-- FL\00C8CHE DE TRANSITION SVG EXTR\00CAMEMENT PURE AU LIEU DU CARACT\00C8RE OBSCURE (\00BF) -->'),
'            <svg class="w-6 h-6 text-amber-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M14 5l7 7m0 0l-7 7m7-7H3"></path></svg>',
'            ',
'            <div class="text-right flex flex-col items-end">',
unistr('                <p class="text-[11px] text-amber-700 uppercase tracking-wide font-black mb-1">Nouvelle \00C9ch\00E9ance</p>'),
unistr('                <!-- UN VRAI S\00C9LECTEUR DE DATE NOUVELLE G\00C9N\00C9RATION -->'),
'                <input type="date" id="renewNewDate" class="px-2 py-1.5 w-40 border border-amber-300 shadow-inner rounded-md text-sm font-bold text-slate-800 outline-none focus:border-amber-700 focus:ring-1 focus:ring-amber-700 bg-white">',
'            </div>',
'        </div>',
'',
'',
'        <div>',
unistr('            <label class="block text-xs font-semibold text-slate-700 mb-1">Nouvelle Prime Annuelle (\20AC)</label>'),
'            <input type="number" id="txtNewPrime" value="1850.00" class="w-full px-3 py-2 border-2 border-amber-300 rounded-md focus:border-amber-700 outline-none bg-white text-sm font-bold text-slate-900">',
unistr('            <p class="text-[10px] text-slate-500 mt-1">*L''IA recommande une augmentation de 2.4% li\00E9e \00E0 l''inflation.</p>'),
'        </div>',
'        ',
'        <div class="mt-4 flex justify-between items-center">',
'            <div class="flex items-center gap-2">',
'                <input type="checkbox" checked class="w-3 h-3 text-amber-700">',
unistr('                <label class="text-[11px] font-medium text-slate-700">Reconduire \00E0 l''identique</label>'),
'            </div>',
unistr('            <!-- CORRIG\00C9 : type="button" emp\00EAche le crash terminal global ! -->'),
'            <button type="button" type="button" onclick="confirmRenewal()" class="bg-amber-700 hover:bg-amber-800 text-white px-4 py-2 rounded-md text-sm font-bold shadow-md transition">',
'                Confirmer',
'            </button>',
'        </div>',
'    </div>',
'',
'</div>',
'',
'',
'                </div>',
'            </div>',
'        </div>',
'    </div>',
'</div>',
''))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp.component_end;
end;
/
