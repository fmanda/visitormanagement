// import axios from 'axios'
import request from '@/utils/rest'
import { getToken } from '@/utils/auth'

// const customRest = axios.create({
//   baseURL: process.env.VUE_APP_BASE_URL,
//   timeout: 5000 // request timeout
// })


export function getVisit(visitID) {
  return request({
    url: 'visit/' + visitID.toString(),
    method: 'get'
  })
}


export function getListVisit() {
  return request({
    url: 'visit',
    method: 'get'
  })
}

export function postVisit(data, img1) {

  const formData = new FormData();
  formData.append('img1', img1)
  // formData.append('test', 'test')
  formData.append('data', JSON.stringify(data));

  for (var pair of formData.entries()) {
      console.log(pair[0]+ ', ' + pair[1]);
  }

  let token = getToken();

  // return customRest.request({
  //     url: 'visit',
  //     method: 'post',
  //     data: formData,
  //     headers: {
  //       'Authorization' : token,
  //       // 'content-type': 'multipart/form-data'
  //     }
  // })
  return request({
    url: 'visit',
    method: 'post',
    data : formData
  })
}

export function getVisitImage(id) {
  return request({
    url: 'visitimage/' + id.toString() ,
    method: 'get'
  })
}

export function getVisitImgURL(id) {
  if (!id) return null;
  return process.env.VUE_APP_IMG_URL + '/'+  id.toString();
}

export function getElapsedTime(startTime){
      // Record end time
      let endTime = new Date();

      // Compute time difference in milliseconds
      let timeDiff = endTime.getTime() - startTime.getTime();

      // Convert time difference from milliseconds to seconds
      timeDiff = timeDiff / 1000;

      // Extract integer seconds that dont form a minute using %
      let seconds = Math.floor(timeDiff % 60); //ignoring uncomplete seconds (floor)

      // Pad seconds with a zero if neccessary
      let secondsAsString = seconds < 10 ? "0" + seconds : seconds + "";

      // Convert time difference from seconds to minutes using %
      timeDiff = Math.floor(timeDiff / 60);

      // Extract integer minutes that don't form an hour using %
      let minutes = timeDiff % 60; //no need to floor possible incomplete minutes, becase they've been handled as seconds

      // Pad minutes with a zero if neccessary
      let minutesAsString = minutes < 10 ? "0" + minutes : minutes + "";

      // Convert time difference from minutes to hours
      timeDiff = Math.floor(timeDiff / 60);

      // Extract integer hours that don't form a day using %
      let hours = timeDiff % 24; //no need to floor possible incomplete hours, becase they've been handled as seconds

      // Convert time difference from hours to days
      timeDiff = Math.floor(timeDiff / 24);

      // The rest of timeDiff is number of days
      let days = timeDiff;

      let totalHours = hours + (days * 24); // add days to hours
      let totalHoursAsString = totalHours < 10 ? "0" + totalHours : totalHours + "";

      if (totalHoursAsString === "00") {
          return minutesAsString + ":" + secondsAsString;
      } else {
          return totalHoursAsString + ":" + minutesAsString + ":" + secondsAsString;
      }
}
