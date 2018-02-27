/*
 * Copyright 2017 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <allocator-passthrough/2.0/GrallocLoader.h>

#include <allocator-hal/2.0/Allocator.h>
#include <allocator-hal/2.0/AllocatorHal.h>
#include <allocator-passthrough/2.0/Gralloc0Hal.h>
#include <allocator-passthrough/2.0/Gralloc1Hal.h>
#include <hardware/gralloc.h>
#include <hardware/hardware.h>
#include <log/log.h>

namespace android {
namespace hardware {
namespace graphics {
namespace allocator {
namespace V2_0 {
namespace passthrough {

const hw_module_t* GrallocLoader::loadModule() {
    const hw_module_t* module;
    int error = hw_get_module(GRALLOC_HARDWARE_MODULE_ID, &module);
    if (error) {
        ALOGE("failed to get gralloc module");
        return nullptr;
    }

    return module;
}

int GrallocLoader::getModuleMajorApiVersion(const hw_module_t* module) {
    return (module->module_api_version >> 8) & 0xff;
}

std::unique_ptr<hal::AllocatorHal> GrallocLoader::createHal(const hw_module_t* module) {
    int major = getModuleMajorApiVersion(module);
    switch (major) {
        case 1: {
            auto hal = std::make_unique<Gralloc1Hal>();
            return hal->initWithModule(module) ? std::move(hal) : nullptr;
        }
        case 0: {
            auto hal = std::make_unique<Gralloc0Hal>();
            return hal->initWithModule(module) ? std::move(hal) : nullptr;
        }
        default:
            ALOGE("unknown gralloc module major version %d", major);
            return nullptr;
    }
}

IAllocator* GrallocLoader::createAllocator(std::unique_ptr<hal::AllocatorHal> hal) {
    auto allocator = std::make_unique<hal::Allocator>();
    return allocator->init(std::move(hal)) ? allocator.release() : nullptr;
}

}  // namespace passthrough
}  // namespace V2_0
}  // namespace allocator
}  // namespace graphics
}  // namespace hardware
}  // namespace android
