module Post::Operation
  class Copy < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(Post, :new)
      step Contract::Build(constant: Post::Contract::Create)
    end
    step Subprocess(Present)
    step Contract::Validate(key: :post)
    step Contract::Persist()
  end
end
