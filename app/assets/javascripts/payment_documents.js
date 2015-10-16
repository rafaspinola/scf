function fillOthers(fields, v) {
	fields.each(function(i, e) {$(e).val(v);});
}


function copy() {
	fillOthers($('input#payments__origin_bank'), $('input#payments__origin_bank:first').val());
	fillOthers($('input#payments__agency'), $('input#payments__agency:first').val());
	fillOthers($('input#payments__emittent'), $('input#payments__emittent:first').val());
	fillOthers($('input#payments__account'), $('input#payments__account:first').val());
}