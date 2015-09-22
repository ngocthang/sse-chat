Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1598283920446155', '674d9ca184601c6b4573fc0789e35d9d',
    scope: 'public_profile', display: 'page', image_size: 'square'
end
