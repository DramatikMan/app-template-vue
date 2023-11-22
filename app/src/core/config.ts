type Values = typeof window.config;

class Config {
    private readonly values: Values;

    constructor() {
        this.values = {
            BACKEND_API_URL: window.config.BACKEND_API_URL,
        };
    }

    get(key: keyof Values): string {
        if (import.meta.env.DEV && Object.hasOwn(import.meta.env, `VITE_${key}`))
            return import.meta.env[`VITE_${key}`];

        return this.values[key];
    }
}

export default new Config();
