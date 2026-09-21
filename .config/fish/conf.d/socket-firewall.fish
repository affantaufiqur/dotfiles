# Route JavaScript package managers through Socket Firewall.
function npm --description 'npm protected by Socket Firewall'
    command sfw npm $argv
end

function pnpm --description 'pnpm protected by Socket Firewall'
    command sfw pnpm $argv
end
