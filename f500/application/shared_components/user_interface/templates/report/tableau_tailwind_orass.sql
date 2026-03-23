prompt --application/shared_components/user_interface/templates/report/tableau_tailwind_orass
begin
--   Manifest
--     ROW TEMPLATE: TABLEAU_TAILWIND_ORASS
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
 p_id=>wwv_flow_imp.id(6352100525840150)
,p_row_template_name=>'Tableau Tailwind Orass'
,p_internal_name=>'TABLEAU_TAILWIND_ORASS'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<tr class="border-b border-slate-100 hover:bg-slate-50 transition">',
'    <td class="p-4"><div class="w-8 h-8 rounded-full bg-slate-300"></div></td>',
'    <td class="p-4 font-bold text-slate-800">#PRENOM# #NOM#</td>',
'    <td class="p-4 text-slate-500">#EMAIL#</td>',
'    ',
unistr('    <!-- L''emoji est maintenant dans le navigateur, en s\00E9curit\00E9 ! -->'),
'    <td class="p-4 font-medium text-slate-700">#TOTAL_POLICES# &#128663;</td>',
'    ',
'    <td class="p-4 text-xs font-semibold tracking-wide">',
'        <span class="#CLASS_STATUT# text-white px-3 py-1 rounded-sm">#STATUT#</span>',
'    </td>',
'        <td class="p-4 flex gap-3 text-lg">',
unistr('        <!-- Bouton \00C9diter (Crayon) -->'),
'        <button type="button" onclick="editClient(#ID#, ''#PRENOM#'', ''#NOM#'')" class="text-slate-400 hover:text-amber-700 transition" title="Modifier">',
'            &#9998;',
'        </button>',
'        <!-- Bouton Supprimer (Corbeille) -->',
'        <button type="button" onclick="deleteClient(#ID#)" class="text-slate-400 hover:text-red-600 transition" title="Supprimer">',
'            &#128465;',
'        </button>',
'    </td>',
'',
'</tr>',
''))
,p_row_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
' <div class="ml-64 mx-8 mb-8 bg-white rounded-lg border border-slate-200 shadow-sm mt-0">',
'    <div class="p-6 border-b border-slate-200 flex justify-between items-center bg-slate-50 rounded-t-lg">',
unistr('        <h3 class="text-lg font-bold text-slate-800">Liste des Clients R\00E9cents</h3>'),
unistr('       <!-- On a simplement ajout\00E9 type="button" -->'),
'<button type="button" onclick="openModal()" class="bg-amber-700 hover:bg-amber-800 text-white px-5 py-2 rounded-md text-sm font-semibold transition shadow-sm">',
'    Ajouter Nouveau Client',
'</button>',
'',
'    </div>',
'    <div class="overflow-x-auto">',
'        <table class="w-full text-left border-collapse">',
'            <thead>',
'                <tr class="text-slate-500 text-xs uppercase tracking-wider border-b border-slate-200">',
'                    <th class="p-4 font-semibold">Photo</th>',
'                    <th class="p-4 font-semibold">Nom</th>',
'                    <th class="p-4 font-semibold">Email</th>',
'                    <th class="p-4 font-semibold">Total Polices</th>',
'                    <th class="p-4 font-semibold">Statut</th>',
'                    <th class="text-left text-xs font-semibold text-slate-400 uppercase tracking-wider p-4">Actions</th>',
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
