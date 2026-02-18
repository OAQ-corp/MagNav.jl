% Auto-generated from src/baseline_plots.jl
% Original Julia signature: function plot_activation(activation = [:relu,:σ,:swish,:tanh]; plot_deriv::Bool  = false, show_plot::Bool   = true, save_plot::Bool   = false, plot_png::String  = "act_func.png")
% Mechanical conversion draft: review before production use.
function out = plot_activation(activation, f___, f__swish, f__tanh_, varargin)
                         plot_deriv::Bool  = false,
                         show_plot::Bool   = true,
                         save_plot::Bool   = false,
                         plot_png::String  = "act_func.png")

    save_plot ? dpi = 500 : dpi = 200

    % setup
    x = LinRange(-6,4,1000)
    p_relu  = relu.(x)
    p_σ     = σ.(x)
    p_swish = swish.(x)
    p_tanh  = tanh.(x)

    d_relu  = ForwardDiff.derivative.(relu,x)
    d_σ     = ForwardDiff.derivative.(σ,x)
    d_swish = ForwardDiff.derivative.(swish,x)
    d_tanh  = ForwardDiff.derivative.(tanh,x)

    if !plot_deriv % plot activation functions
        p1 = plot(xlab="z",ylab="f(z)",xlim=(-6,4),ylim=(-2,4),
                  legend=:topleft,margin=2*mm,dpi=dpi)
        :relu  in activation && plot!(p1,x,p_relu ,lab="ReLU"   ,lw=2,ls=:solid)
        :σ     in activation && plot!(p1,x,p_σ    ,lab="sigmoid",lw=2,ls=:solid)
        :swish in activation && plot!(p1,x,p_swish,lab="Swish"  ,lw=2,ls=:dash)
        :tanh  in activation && plot!(p1,x,p_tanh ,lab="tanh"   ,lw=2,ls=:dot)
    else % plot derivatives of activation functions
        p1 = plot(xlab="z",ylab="f'(z)",xlim=(-6,4),ylim=(-0.5,1.5),
                  legend=:topleft,margin=2*mm,dpi=dpi)
        :relu  in activation && plot!(p1,x,d_relu ,lab="ReLU"   ,lw=2,ls=:solid)
        :σ     in activation && plot!(p1,x,d_σ    ,lab="sigmoid",lw=2,ls=:solid)
        :swish in activation && plot!(p1,x,d_swish,lab="Swish"  ,lw=2,ls=:dash)
        :tanh  in activation && plot!(p1,x,d_tanh ,lab="tanh"   ,lw=2,ls=:dot)
    end
end
