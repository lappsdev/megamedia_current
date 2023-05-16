import { ApplicationRecord } from './application_record';
import { attr, belongsTo } from 'spraypaint'
import { User } from './user.model'
import { Device } from './device.model'

export const SshCommand = ApplicationRecord.extend({
    static: {
        jsonapiType: 'ssh_commands'
    },
    attrs: {
        command: attr(),
        output: attr(),
        sshRunner: belongsTo({ type: Device })
    },
    methods: {
        setHomePageCommand(homepage) {
            this.command = `sudo sed -i '/^@\\/usr\\/bin\\/chromium-browser/d' /etc/xdg/lxsession/LXDE-pi/autostart && sudo echo '@/usr/bin/chromium-browser --check-for-update-interval=1 --simulate-critical-update --no-first-run --noerrdialogs --start-fullscreen --start-maximized --disable-notifications --disable-restore-session-state  --disable-infobars --incognito ${homepage}' | sudo tee -a /etc/xdg/lxsession/LXDE-pi/autostart && echo 'Setado com sucesso!'`
        }
    }
})