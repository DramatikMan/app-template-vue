import {defineStore} from "pinia";

export interface State {
    count: number;
}

const initial: State = {count: 0};

export const use = defineStore("main", {
    state: () => initial,
    actions: {
        addCount() {
            this.count++;
        },
    },
});
