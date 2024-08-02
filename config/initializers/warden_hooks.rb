# frozen_string_literal: true

# Warden::Manager.after_authentication do |user, auth, opts|
#     if user.persisted?
#       user.generate_otp
#       auth.logout
#       auth.env['devise.skip_timeout'] = true
#       auth.env['warden'].session(opts[:scope])[:otp_required] = true
#     end
# end
