import { fal } from "@fal-ai/client";
import { parseArgs } from "node:util";

// Define arguments
const options = {
    prompt: {
        type: "string",
        short: "p",
    },
    "aspect-ratio": {
        type: "string",
        default: "1:1",
        short: "a",
    },
    "num-images": {
        type: "string", // Parsing as string to safer handling, converted to int later if needed or passed as is if API accepts check
        default: "1",
        short: "n",
    },
    "output-format": {
        type: "string",
        default: "png",
        short: "f",
    },
};

const main = async () => {
    try {
        const { values } = parseArgs({
            options,
            strict: false, // Allow other args if necessary, but mainly to prevent crash on unknown
        });

        if (!values.prompt) {
            console.error("Error: --prompt argument is required.");
            console.log(`Usage: node generate_image.js --prompt "Your image description" [--aspect-ratio "16:9"] [--num-images 1] [--output-format png]`);
            process.exit(1);
        }

        // Ensure API Key is set
        if (!process.env.FAL_KEY) {
            console.warn("Warning: FAL_KEY environment variable is not set. The request may fail if not authenticated.");
        }

        console.log(`Generating image for prompt: "${values.prompt}"`);
        console.log(`Aspect Ratio: ${values["aspect-ratio"]}, Format: ${values["output-format"]}`);

        const result = await fal.subscribe("fal-ai/nano-banana-pro", {
            input: {
                prompt: values.prompt,
                aspect_ratio: values["aspect-ratio"],
                num_images: parseInt(values["num-images"], 10),
                output_format: values["output-format"],
            },
            logs: true,
            onQueueUpdate: (update) => {
                if (update.status === "IN_PROGRESS") {
                    // Basic log handling
                    if (update.logs) {
                        update.logs.map((log) => log.message).forEach(console.log);
                    }
                }
            },
        });

        console.log("Generation Complete!");
        if (result.data && result.data.images) {
            result.data.images.forEach((img, index) => {
                console.log(`Image ${index + 1}: ${img.url}`);
            });
        } else {
            console.log("No images returned.", result);
        }

    } catch (error) {
        console.error("An error occurred:", error);
        process.exit(1);
    }
};

main();
