import {createAsyncThunk} from "@reduxjs/toolkit";
import {RootState} from "store/types";
import {TUser} from "./types";
import api from "axios";
import {AxiosError} from "axios";
import {notification} from "antd";
import qs from 'qs'

const userLogin = createAsyncThunk<void,
    {
        userInfo: TUser;
        url: string;
        redirectUrl: string;
    },
    { rejectValue: string; state: RootState }>("user/login", async (args, thunkAPI) => {
    api({
        url: args.url,
        method: "POST",
        headers: {
            'content-type': 'application/x-www-form-urlencoded',
            'Upgrade-Insecure-Requests': '1',
            'Cache-Control': 'max-age=0'

        },
        data: qs.stringify(args.userInfo, {arrayFormat: 'repeat'}),
    }).catch((err: Error | AxiosError) => {
        //XHR forced to follow redirect 302, which results at the end in a CORS error.Only way to catch this, its to verify if respsones is undefined.
        if (api.isAxiosError(err)) {
            if (!err.response) {
                window.location.href = args.redirectUrl;
                return;
            }
        }

        notification.error({
            message: "Error",
            description: "Unable to create complete your profile",
        });
    });
});
export {userLogin};
