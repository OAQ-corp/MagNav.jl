% Auto-generated from src/tolles_lawson.jl
% Original Julia signature: function get_TL_term_ind(term::Symbol, terms)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function ind = get_TL_term_ind(term, terms)
    ind = [];

    terms = [terms;] % ensure vector
% TODO(Julia->MATLAB): assert term in terms "term $term not in terms"

    x = [1.0]
    N_term  = length(create_TL_A(x,x,x;terms=term))
    N_terms = length(create_TL_A(x,x,x;terms=terms))
    i_term  = findfirst(term == terms)

% TODO(Julia->MATLAB): ind_ = (1:N_term) .+ length(create_TL_A(x,x,x;terms=terms(1:i_term-1)))
% TODO(Julia->MATLAB): ind  = (1:N_terms .∈ (ind_,))

% return (ind)
end % function get_TL_term_ind
end
