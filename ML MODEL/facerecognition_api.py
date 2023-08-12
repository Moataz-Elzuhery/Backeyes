from flask import Flask, jsonify, request
import cv2
from simple_facerec import SimpleFacerec
from simple_facerec import adjust_gamma
import os
import numpy as np

app = Flask(__name__)

# Initialize SimpleFacerec instance
sfr = SimpleFacerec()

# Create folder for unrecognized faces
if not os.path.exists('unknown_faces'):
    os.makedirs('unknown_faces')



@app.route('/add_known_faces', methods=['POST'])
def add_known_faces():
    # Retrieve the image files and names from the request
    images = request.files.getlist('images')
    names = request.form.getlist('names')

    # Iterate over the image files and corresponding names
    for image, name in zip(images, names):
        # Read the image file
        img = cv2.imdecode(np.frombuffer(image.read(), np.uint8), cv2.IMREAD_COLOR)

        # Add the known face to the SimpleFacerec instance
        sfr.add_known_face(img, name)

    # Prepare the response
    response = {
        'message': 'Known faces added successfully.'
    }

    return jsonify(response)

@app.route('/recognize', methods=['POST'])
def recognize_faces():
    file = request.files['video']
    video_path = 'video.mp4'
    file.save(video_path)

    cap = cv2.VideoCapture(video_path)
    last_unknown_face = None
    unknown_face_saved = False
    face_data = []

    while True:
        ret, frame = cap.read()

        if not ret:
            break

        # Apply gamma correction to the frame
        gamma_corrected_frame = adjust_gamma(frame, gamma=1.5)

        face_locations, face_names = sfr.detect_known_faces(gamma_corrected_frame)

        for face_loc, name in zip(face_locations, face_names):
            y1, x2, y2, x1 = face_loc[0], face_loc[1], face_loc[2], face_loc[3]

            if name == "Unknown":
                if last_unknown_face is None or not unknown_face_saved:
                    unknown_face_saved = True
                    last_unknown_face = gamma_corrected_frame[y1:y2, x1:x2]
                    
                    # Generate unique filename for the unknown face image
                    filename = f"unknown_faces/unknown_face_{len(face_data)}.jpg"
                    file_path = os.path.join(os.getcwd(), filename)
                    
                    # Save the thumbnail image
                    cv2.imwrite(file_path, last_unknown_face)
                    
                    # Get the base URL of the local server
                    base_url = request.host_url.rstrip('/')
                    
                    # Generate URL for the thumbnail image
                    thumbnail_url = f"{base_url}/{filename}"
                    
                    # Store the URL in the response
                    face_data.append({
                    	'name': name,
                    	'thumbnail': thumbnail_url
   		    	})
            else:
                print({
                    'name': name,
                    'thumbnail': None
                })

            # Draw face bounding boxes on the frame
            cv2.rectangle(gamma_corrected_frame, (x1, y1), (x2, y2), (0, 0, 255), 2)
            cv2.putText(gamma_corrected_frame, name, (x1, y1 - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.9, (0, 0, 255), 2)

        cv2.imshow('Video Stream', gamma_corrected_frame)
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

    cap.release()
    cv2.destroyAllWindows()
    os.remove(video_path)

    response = {
        'faces': face_data
    }

    return jsonify(response)



if __name__ == '__main__':
    
    app.run()
