prompt --application/shared_components/user_interface/templates/report/tableau_polices_tailwind
begin
--   Manifest
--     ROW TEMPLATE: TABLEAU_POLICES_TAILWIND
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.10.31'
,p_release=>'23.2.0'
,p_default_workspace_id=>3628745592366285
,p_default_application_id=>500
,p_default_id_offset=>0
,p_default_owner=>'ORASSADM'
);
wwv_flow_imp_shared.create_row_template(
 p_id=>wwv_flow_imp.id(6406471597498256)
,p_row_template_name=>'Tableau Polices Tailwind'
,p_internal_name=>'TABLEAU_POLICES_TAILWIND'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<tr class="border-b border-slate-100 hover:bg-slate-50 transition">',
'    <td class="p-4 font-bold text-slate-800">#NUMERO_POLICE#</td>',
'    <td class="p-4">',
'        <div class="flex items-center gap-3">',
'            <div class="w-8 h-8 rounded-full bg-slate-300 flex-shrink-0"></div>',
'            <span class="font-semibold text-slate-700">#CLIENT_NOM#</span>',
'        </div>',
'    </td>',
'    <td class="p-4">',
'        <div class="font-semibold text-slate-800">#VEHICULE#</div>',
'        <div class="text-xs text-slate-500">#IMMATRICULATION#</div>',
'    </td>',
'    <td class="p-4 font-medium text-slate-600">#FORMULE#</td>',
'    <td class="p-4 text-amber-700 font-semibold">#DATE_ECHEANCE#</td>',
'    <td class="p-4">',
'        <span class="bg-slate-700 text-white px-3 py-1 rounded-sm text-xs font-semibold tracking-wide">#STATUT#</span>',
'    </td>',
'   <td class="p-4 text-right flex justify-end gap-4 items-center">',
'    ',
unistr('    <!-- 1. Bouton \0152il (Consulter Vue D\00E9taill\00E9e) -->'),
'    <button type="button" onclick="showDetailPolice(''#ID#'', ''#CLIENT_ID#'', ''#NUMERO_POLICE#'', ''#CLIENT_NOM#'', ''#VEHICULE#'', ''#IMMATRICULATION#'', ''#FORMULE#'', ''#DATE_ECHEANCE#'', ''#PRIME_ANNUELLE#'', ''#STATUT#'')" class="text-slate-500 hover:text-slate-9'
||'00 transition" title="Consulter la Police">',
'        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path><path stroke-linecap="round" stroke-linejoin="round'
||'" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path></svg>',
'    </button>',
'',
unistr('    <!-- 2. Bouton Crayon (\00C9diter / Update via API) -->'),
'    <button type="button" onclick="editPolice(''#ID#'', ''#NUMERO_POLICE#'', ''#CLIENT_ID#'', ''#VEHICULE#'', ''#IMMATRICULATION#'', ''#FORMULE#'', ''#DATE_ECHEANCE#'', ''#PRIME_ANNUELLE#'', ''#STATUT#'')" class="text-slate-500 hover:text-amber-600 transition border-l'
||' border-slate-200 pl-4" title="Modifier rapidement">',
'        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.'
||'732z"></path></svg>',
'    </button>',
'',
unistr('    <!-- 3. Bouton Poubelle (Supprimer d\00E9finitivement via API) -->'),
unistr('    <button type="button" onclick="deletePolice(''#ID#'')" class="text-slate-500 hover:text-red-600 transition" title="D\00E9truire">'),
'        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0'
||' 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path></svg>',
'    </button>',
'    ',
'</td>',
'',
'</tr>',
''))
,p_row_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
' <div class="bg-white rounded-lg border border-slate-200 shadow-sm mt-8">',
'    <div class="p-6 border-b border-slate-200 flex justify-between items-center bg-slate-50 rounded-t-lg">',
unistr('        <h3 class="text-lg font-bold text-slate-800">R\00E9pertoire des Polices Auto</h3>'),
'        <button onclick="openModalPolice()" type="button" class="bg-amber-700 hover:bg-amber-800 text-white px-5 py-2 rounded-md text-sm font-semibold transition shadow-sm flex items-center gap-2">',
unistr('            <span>&#10133;</span> Cr\00E9er une Police'),
'        </button>',
'    </div>',
'    <div class="overflow-x-auto">',
'        <table class="w-full text-left border-collapse">',
'            <thead>',
'                <tr class="text-slate-500 text-xs uppercase tracking-wider border-b border-slate-200">',
unistr('                    <th class="p-4 font-semibold">N\00B0 Police</th>'),
'                    <th class="p-4 font-semibold">Client</th>',
unistr('                    <th class="p-4 font-semibold">V\00E9hicule & Immat.</th>'),
'                    <th class="p-4 font-semibold">Formule</th>',
unistr('                    <th class="p-4 font-semibold">\00C9ch\00E9ance</th>'),
'                    <th class="p-4 font-semibold">Statut</th>',
'                    <th class="p-4 font-semibold text-right">Actions</th>',
'                </tr>',
'            </thead>',
'            <tbody class="text-sm">',
''))
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'             </tbody>',
'        </table>',
'    </div>',
'</div>',
''))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_theme_id=>42
,p_theme_class_id=>7
,p_translate_this_template=>'N'
);
wwv_flow_imp.component_end;
end;
/
